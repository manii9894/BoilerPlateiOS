//
//  AVPlayer+Extension.swift
//  AudioBlend
//
//  Created by Abdul Rehman on 08/09/2022.
//

import Foundation
import AVFoundation

extension AVPlayer {
    var isPlaying: Bool {
        return rate != 0 && error == nil
    }
}
