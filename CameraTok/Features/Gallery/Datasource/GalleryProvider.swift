//
//  GalleryProvider.swift
//  CameraTok
//
//  Created by Bryan A Bolivar M on 13/08/23.
//

import Foundation
import AVFoundation

class GalleryProvider {
    var source: GalleryProviderSource
    
    init(source: GalleryProviderSource) {
        self.source = source
    }
    
    func fetchVideos(from date: Date, count: Int = 15, completion: @escaping ([Video]) -> Void) {
        source.fetchVideos(from: date, count: count) { videos in
            completion(videos)
        }
    }
    
    func fetchVideo(for video: Video, completion: @escaping (AVAsset) -> Void) {
        source.fetchVideo(for: video) { videoAsset in
            completion(videoAsset)
        }
    }
    
}
