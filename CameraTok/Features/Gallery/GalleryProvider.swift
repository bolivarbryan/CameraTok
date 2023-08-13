//
//  GalleryProvider.swift
//  CameraTok
//
//  Created by Bryan A Bolivar M on 13/08/23.
//

import Foundation

class GalleryProvider {
    var videos: [Video] = []
    
    init() {
        
    }
    
    func fetchVideos(from date: Date) -> [Video] {
        return Array(videos.filter { video in
            video.date > date
        }.prefix(15))
    }
}
