//
//  Int+Extension.swift
//  AudioBlend
//
//  Created by Abdul Rehman on 08/09/2022.
//

import Foundation

extension Int {
    
    func getTimeString() -> String {
        
        let minutes = self / 60 % 60
        let seconds = self % 60
        return String(format:"%02i:%02i", minutes, seconds)
        
    }
    
}
