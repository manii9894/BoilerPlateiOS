//
//  URL+Extension.swift
//  CheckDrv
//
//  Created by Abdul Rehman on 08/06/2022.
//

import AVKit

extension URL {
    
    func getVideoThumbnail(completion: @escaping ((UIImage?) -> Void)) {

        DispatchQueue.global(qos: .utility).async {
            let asset = AVAsset(url: self)
            let assetImgGenerate = AVAssetImageGenerator(asset: asset)
            assetImgGenerate.appliesPreferredTrackTransform = true

            let time = CMTimeMakeWithSeconds(0.0, preferredTimescale: 600)
            do {
                let img = try assetImgGenerate.copyCGImage(at: time, actualTime: nil)
                let thumbnail = UIImage(cgImage: img)
                DispatchQueue.main.async {
                    completion(thumbnail)
                }
            }
            catch {
              print(error.localizedDescription)
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }

    }
    
}
