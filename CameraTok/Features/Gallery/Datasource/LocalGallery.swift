//
//  LocalGallery.swift
//  CameraTok
//
//  Created by Bryan A Bolivar M on 15/08/23.
//

import Foundation
import Photos
import AVFoundation

protocol LocalGallery: GalleryProviderSource { }

class LocalGalleryImplementation: LocalGallery {
    var videoAsset: AVAsset {
        let testBundle = Bundle(for: type(of: self))
        let videoURL = testBundle.url(forResource: "output", withExtension: "mp4")
        return AVAsset(url: videoURL!)
    }
    
    func fetchVideos(from date: Date) -> [Video] {
        return (1...40).map {
            let asset = PHAsset()
            return Video(date: Date(timeIntervalSinceNow: TimeInterval($0 * 100)), asset: asset)
        }
    }
    
    func fetchVideos(from date: Date, count: Int, completion: @escaping ([Video]) -> Void) {
        completion(fetchVideos(from: Date()))
    }
    
    func fetchVideo(for video: Video, completion: @escaping (AVAsset) -> Void) {
        completion(videoAsset)
    }
}
