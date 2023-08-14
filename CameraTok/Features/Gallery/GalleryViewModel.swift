//
//  GalleryViewModel.swift
//  CameraTok
//
//  Created by Bryan A Bolivar M on 13/08/23.
//

import Foundation
import SwiftUI

class GalleryViewModel: ObservableObject {
    var currentPage: Int = 1
    var source: GalleryProviderSource
    @Published var videos: [Video] = []
    
    var lastVideo: Video? {
        return videos.last
    }
    
    init(source: GalleryProviderSource) {
        self.source = source
    }
    
    func moveNextPage() {
        guard let date = videos.last?.date else {
            return
        }
        currentPage += 1
        
        let provider = GalleryProvider(source: source)
        provider.fetchVideos(from: date) { galleryVideos in
            self.videos.append(contentsOf: galleryVideos)
        }
    }
    
    func fetchLastVideos() {
        let provider = GalleryProvider(source: source)
        provider.fetchVideos(from: Date()) { galleryVideos in
            self.videos = galleryVideos
        }
    }
}
