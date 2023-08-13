//
//  Video.swift
//  CameraTok
//
//  Created by Bryan A Bolivar M on 13/08/23.
//

import Foundation
import UIKit
import AVFoundation

struct Video {
    var date: Date
    var metadata: String
    var asset: AVAsset
    
    var previewImage: UIImage? {
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        imageGenerator.appliesPreferredTrackTransform = true
        
        do {
            let cgImage = try imageGenerator.copyCGImage(at: .zero, actualTime: nil)
            return UIImage(cgImage: cgImage)
        } catch {
            return nil
        }
    }
    
    init(date: Date = Date(), metadata: String = "", asset: AVAsset) {
        self.date = date
        self.metadata = metadata
        self.asset = asset
    }
    
}
