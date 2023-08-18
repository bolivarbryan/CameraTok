//
//  ReelViewModel.swift
//  CameraTok
//
//  Created by Bryan A Bolivar M on 14/08/23.
//

import Foundation
import AVFoundation

class ReelViewModel: ObservableObject {
    var currentPage: Int = 1
    var source: GalleryProviderSource
    @Published var videos: [Video] = []
    
    var currentVideo: Video? {
        guard videos.count > currentPage else {
            return nil
        }
        return videos[currentPage]
    }
    
    public init(videos: [Video], currentPage: Int, source: GalleryProviderSource) {
        self.source = source
        self.videos = videos
        self.currentPage = currentPage
    }
    
    func moveNextPage() {
        currentPage += 1
        if let video = currentVideo {
            let provider = GalleryProvider(source: source)
            provider.fetchVideo(for: video) { videoAsset in
                print(videoAsset)
            }
        } else {
            print("LAST PAGE")
            currentPage -= 1
        }
    }
}
