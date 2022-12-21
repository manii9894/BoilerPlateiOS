//
//  NetworkManager.swift
//  FoodOrderingApp
//
//  Created by Abdul Rehman on 17/03/2022.
//

import Foundation
import Combine
import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    private var cancellables = Set<AnyCancellable>()
    
    /**
        It makes requests to the server with some parameters and gives response.
     
        - Precondition: `responseType` model should be match with the API response.
        - Returns: A model as the generic type is passed or and error.
     */
    func request<T: Decodable>(endpoint: Endpoint, params: Any? = nil, method: APIMethod, responseType: T.Type, headers: [HttpHeader]? = nil) -> Future<T, Error> {
        
        return Future<T, Error> { [weak self] promise in
            
            guard Network.isAvailable else {
                return promise(.failure(NetworkError.internetError))
            }
            
            guard let self = self, let url = URL(string: endpoint.urlString + (method == .GET ? self.buildQueryString(fromDictionary: params) : "")) else {
                return promise(.failure(NetworkError.invalidURL))
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            request.timeoutInterval = 30
            
            if method != .GET {
                if let params = params as? [String: Any] {
                    request.httpBody = self.getData(from: params)
                } else if let params = params as? Data {
                    request.httpBody = params
                }
            }
            
            if let headers = headers {
                request = self.setupHeaders(request: request, headers: headers)
            }
            self.startTask(for: request, responseType: responseType)
                .sink(receiveCompletion: { (completion) in
                    if case let .failure(error) = completion {
                        switch error {
                        case _ as DecodingError:
                            promise(.failure(NetworkError.responseError("Unable to decode response")))
                        case let apiError as NetworkError:
                            promise(.failure(apiError))
                        default:
                            promise(.failure(NetworkError.unknown))
                        }
                    }
                }, receiveValue: { promise(.success($0)) })
                .store(in: &self.cancellables)
            
        }
    }
    
    /**
        It makes requests to the server with some parameters / Images data and gives response.
     
        - Precondition: `responseType` model should be match with the API response.
        - Returns: A model as the generic type is passed or and error.
     */
    func request<T: Decodable>(endpoint: Endpoint, params: [String: Any]? = nil, media: [MediaAttachment], responseType: T.Type, headers: [HttpHeader]? = nil) -> Future<T, Error> {
        
        return Future<T, Error> { [weak self] promise in
            
            guard Network.isAvailable else {
                return promise(.failure(NetworkError.internetError))
            }
            
            guard let self = self, let url = URL(string: endpoint.urlString) else {
                return promise(.failure(NetworkError.invalidURL))
            }
            
            let request = MultipartFormDataRequest(url: url)
            if let _params = params {
                for (key, value) in _params {
                    request.addTextField(named: key, value: value as! String)
                }
            }
            for obj in media {
                request.addDataField(media: obj)
            }
            var urlRequest = request.asURLRequest()
            if let headers = headers {
                urlRequest = self.setupHeaders(request: urlRequest, headers: headers)
            }
            urlRequest.timeoutInterval = 600
            
            self.startTask(for: urlRequest, responseType: responseType)
                .sink(receiveCompletion: { (completion) in
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
                }, receiveValue: { promise(.success($0)) })
                .store(in: &self.cancellables)

        }
    }
    
    private func startTask<T: Decodable>(for urlRequest: URLRequest, responseType: T.Type) -> Future<T, Error> {
        
        return Future<T, Error> { [unowned self] promise in
            URLSession.shared.dataTaskPublisher(for: urlRequest)
                .subscribe(on: DispatchQueue.global(qos: .background))
                .tryMap { (data, response) -> Data in
                    self.printAPIResponse(data: data)
                    guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                        if let response = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                            if response.code == 401 {
                                throw NetworkError.sessionExpired
                            }
                            throw NetworkError.responseError(response.message)
                        }
                        throw NetworkError.generic
                    }
                    return data
                }
                .decode(type: T.self, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { (completion) in
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
                }, receiveValue: { promise(.success($0)) })
                .store(in: &self.cancellables)
        }
        
    }
    
    private func setupHeaders(request: URLRequest, headers: [HttpHeader]) -> URLRequest {
        
        var urlRequest = request
        headers.forEach { header in
            if let header = header.getHeader() {
                urlRequest.setValue(header.value, forHTTPHeaderField: header.field)
            }
        }
        return urlRequest
        
    }
    
    private func printAPIResponse(data: Data) {
        if let responseString = data.prettyPrintedJSONString {
            print("----- API RESPONSE -----\n", responseString)
        }
    }
    
    private func getData(from params: [String: Any]) -> Data? {
        return try? JSONSerialization.data(withJSONObject: params)
    }
    
    private func buildQueryString(fromDictionary parameters: Any?) -> String {
        
        guard let parameters = parameters as? [String: String] else {
            return ""
        }
        var urlVars = [String]()
        for (var k, var v) in parameters {
            let characters = (CharacterSet.urlQueryAllowed as NSCharacterSet).mutableCopy() as! NSMutableCharacterSet
            characters.removeCharacters(in: "&")
            v = v.addingPercentEncoding(withAllowedCharacters: characters as CharacterSet)!
            k = k.addingPercentEncoding(withAllowedCharacters: characters as CharacterSet)!
            urlVars += [k + "=" + "\(v)"]
        }
        return (!urlVars.isEmpty ? "?" : "") + urlVars.joined(separator: "&")
        
    }
    
}

struct MediaAttachment {
    
    let key: String
    let data: Data
    let mimeType: String
    let fileName: String
    
}
