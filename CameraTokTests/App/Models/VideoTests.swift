//
//  VideoTests.swift
//  CameraTokTests
//
//  Created by Bryan A Bolivar M on 13/08/23.
//

import XCTest
import AVFoundation
@testable import CameraTok

final class VideoTests: XCTestCase {
    
    var videoAsset: AVAsset {
        let testBundle = Bundle(for: type(of: self))
        let videoURL = testBundle.url(forResource: "output", withExtension: "mp4")
        return AVAsset(url: videoURL!)
    }

    func testVideoObjectHasADefaultDate() {
        let video = Video(date: Date(), asset: videoAsset)
        XCTAssertNotNil(video.date)
    }
    
    func testVideoObjectHasAImageBaseFrame() {
        let video = Video(asset: videoAsset)
        XCTAssertNotNil(video.previewImage)
    }
    
    func testVideoObjectHasMetadata() {
        let video = Video(metadata: "This is a nice video", asset: videoAsset)
        XCTAssertEqual(video.metadata, "This is a nice video")
    }
    
    func testVideoObjectHasAsset() {
        let video = Video(asset: videoAsset)
        XCTAssertNotNil(video.asset)
    }
    
}
