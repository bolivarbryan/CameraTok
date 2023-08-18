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
    
    var videoList: [Video] {
        return (1...40).map {
            return Video(date: Date(timeIntervalSinceNow: TimeInterval($0 * 100)), asset: videoAsset)
        }
    }
    
    func testGalleryLoadsLast15Videos() {
        let startDate = Date()
        let galleryProvider = GalleryProvider(source: LocalGalleryImplementation())
        galleryProvider.fetchVideos(from: startDate) { videos in
            XCTAssert(videos.count == 15, "videos count should be 15, got \(videos.count)")
        }
    }
    
    func testGalleryViewModelLoadsSecondPage() {
        let viewModel = GalleryViewModel(source: LocalGalleryImplementation())
        viewModel.fetchLastVideos()
        XCTAssertEqual(viewModel.videos.count, 15)
        XCTAssertEqual(viewModel.currentPage, 1)
        viewModel.moveNextPage()
        XCTAssertEqual(viewModel.currentPage, 2)
        XCTAssertEqual(viewModel.videos.count, 30)
    }
    
    func testLastVideo() {
        let viewModel = GalleryViewModel(source: LocalGalleryImplementation())
        viewModel.fetchLastVideos()
        XCTAssertEqual(viewModel.videos.last, viewModel.lastVideo)
    }
    
    func testEmptyGallery() {
        let viewModel = GalleryViewModel(source: EmptyGalleryImplementation())
        viewModel.fetchLastVideos()
        XCTAssertNil(viewModel.lastVideo)
        XCTAssertTrue(viewModel.videos.isEmpty)
        viewModel.moveNextPage()
        XCTAssertEqual(viewModel.currentPage, 1)
    }
}
