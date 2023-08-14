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
    @Published var videoAsset: AVAsset
    
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
        
        let testBundle = Bundle(for: type(of: self))
        let videoURL = testBundle.url(forResource: "output", withExtension: "mp4")
        videoAsset = AVAsset(url: videoURL!)
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
    
    func fetchVideoAsset(completion: @escaping () -> Void) {
        guard let video = currentVideo else {
            return
        }
        source.fetchVideo(for: video) { asset in
            self.videoAsset = asset
            completion()
        }
    }
     
}
