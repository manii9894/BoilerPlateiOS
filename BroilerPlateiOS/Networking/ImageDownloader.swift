//
//  ImageDownloader.swift
//  FoodOrderingApp
//
//  Created by Abdul Rehman on 17/03/2022.
//

import Foundation
import Combine
import UIKit

class ImageDownloader {
    
    static let shared = ImageDownloader()
    private let cache = NSCache<NSString, UIImage>()
    private var cancellables = Set<AnyCancellable>()
    
    private init() {}
    
    func getVideoThumbnail(from url: URL) -> Future<UIImage, Error> {
        
        return Future<UIImage, Error> { [unowned self] promise in
            let cacheKey = NSString(string: url.absoluteString)
            
            if let image = self.cache.object(forKey: cacheKey) {
                return promise(.success(image))
            }
            
            guard Network.isAvailable else {
                return promise(.failure(NetworkError.internetError))
            }
            
            url.getVideoThumbnail { image in
                if let image = image {
                    self.cache.setObject(image, forKey: cacheKey)
                    return promise(.success(image))
                } else {
                    return promise(.failure(NetworkError.generic))
                }
            }
        }
        
    }
    
    func downloadImage(from urlString: String) -> Future<UIImage, Error> {
        
        return Future<UIImage, Error> { [unowned self] promise in
            let cacheKey = NSString(string: urlString)
            
            if let image = self.cache.object(forKey: cacheKey) {
                return promise(.success(image))
            }
            
            guard Network.isAvailable else {
                return promise(.failure(NetworkError.internetError))
            }
            
            guard let url = URL(string: urlString) else {
                return promise(.failure(NetworkError.generic))
            }
            
            URLSession.shared.configuration.timeoutIntervalForRequest = 10
            
            URLSession.shared.dataTaskPublisher(for: url)
                .subscribe(on: DispatchQueue.global(qos: .background))
                .tryMap { (data, response) -> Data in
                    guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                        guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                            if let response = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                                throw NetworkError.responseError(response.message)
                            }
                            throw NetworkError.generic
                        }
                        return data
                    }
                    return data
                }
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    if case let .failure(error) = completion {
                        switch error {
                        case let decodingError as DecodingError:
                            promise(.failure(decodingError))
                        case let apiError as NetworkError:
                            promise(.failure(apiError))
                        default:
                            promise(.failure(NetworkError.unknown))
                        }
                    }
                } receiveValue: { data in
                    guard let image = UIImage(data: data) else {
                        return promise(.failure(NetworkError.generic))
                    }
                    self.cache.setObject(image, forKey: cacheKey)
                    return promise(.success(image))
                }
                .store(in: &cancellables)
            
        }
    }
    
}
