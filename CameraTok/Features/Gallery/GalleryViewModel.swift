//
//  GalleryViewModel.swift
//  CameraTok
//
//  Created by Bryan A Bolivar M on 13/08/23.
//

import Foundation
import SwiftUI

protocol GalleryViewModelDelegate {
    func didSelectVideo(_ video: Video, index: Int)
}

class GalleryViewModel: ObservableObject {
    var source: GalleryProviderSource
    var delegate: GalleryViewModelDelegate?
    
    @Published var videos: [Video] = []
    @Published var selectedDate = Date() {
        didSet {
            videos = []
            fetchLastVideos()
        }
    }
    
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
        
        let provider = GalleryProvider(source: source)
        provider.fetchVideos(from: date, count: 15) { galleryVideos in
            self.videos.append(contentsOf: galleryVideos)
        }
    }
    
    func fetchLastVideos() {
        let provider = GalleryProvider(source: source)
        provider.fetchVideos(from: selectedDate, count: 15) { galleryVideos in
            self.videos = galleryVideos.sorted(by: { lhs, rhs in
                lhs.date >= rhs.date
            })
        }
    }
    
    func selectVideo(_ video: Video) {
        let index = videos.firstIndex(of: video) ?? 0
        self.delegate?.didSelectVideo(video, index: index)
    }
}
