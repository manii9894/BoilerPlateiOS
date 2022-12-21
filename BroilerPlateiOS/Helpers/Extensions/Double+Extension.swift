//
//  TimeInterval+Extension.swift
//  AudioBlend
//
//  Created by Abdul Rehman on 08/09/2022.
//

import Foundation

extension Double {
    
    var durationString: String {
        let interval = Int(self)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        let hours = (interval / 3600)
        if hours == 0 {
            return String(format:"%02i:%02i", minutes, seconds)
        }
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
}
