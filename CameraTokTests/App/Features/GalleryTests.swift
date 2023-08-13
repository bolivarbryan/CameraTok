//
//  GalleryTests.swift
//  CameraTokTests
//
//  Created by Bryan A Bolivar M on 13/08/23.
//

import XCTest
import AVFoundation
@testable import CameraTok

final class GalleryTests: XCTestCase {
    var videoAsset: AVAsset {
        let testBundle = Bundle(for: type(of: self))
        let videoURL = testBundle.url(forResource: "output", withExtension: "mp4")
        return AVAsset(url: videoURL!)
    }
    
    func testGalleryLoadsLast15Videos() {
        let startDate = Date()
        let galleryProvider = GalleryProvider()
        galleryProvider.videos = (1...20).map {
            return Video(date: Date(timeIntervalSinceNow: TimeInterval($0 * 100)), asset: videoAsset)
        }
        let videos = galleryProvider.fetchVideos(from: startDate)
        XCTAssert(videos.count == 15, "videos count should be 15, got \(videos.count)")
    }
}
