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
    
    func fetchVideos(from date: Date, completion: @escaping ([Video]) -> Void) {
        source.fetchVideos(from: date) { videos in
            completion(videos)
        }
    }
    
}
