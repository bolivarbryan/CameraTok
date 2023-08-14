//
//  Video.swift
//  CameraTok
//
//  Created by Bryan A Bolivar M on 13/08/23.
//

import Foundation
import UIKit
import AVFoundation
import Photos

class Video: Equatable, Identifiable, Hashable {
    var hashValue: Int {
        return id.hashValue
    }
    
    var id = UUID()
    var date: Date
    var metadata: String
    var asset: PHAsset
    var previewImage: UIImage?
    
    init(date: Date = Date(), metadata: String = "", asset: PHAsset) {
        self.date = date
        self.metadata = metadata
        self.asset = asset
    }
    
    init(from asset: PHAsset) {
        self.date = asset.creationDate ?? Date()
        self.metadata = asset.description
        self.asset = asset
    }
    

    static func == (lhs: Video, rhs: Video) -> Bool {
        return lhs.asset == rhs.asset
    }
}
