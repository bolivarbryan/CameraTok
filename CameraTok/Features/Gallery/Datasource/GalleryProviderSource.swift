//
//  GalleryProviderSource.swift
//  CameraTok
//
//  Created by Bryan A Bolivar M on 13/08/23.
//

import Foundation
import AVFoundation

protocol GalleryProviderSource {
    func fetchVideos(from date: Date, count: Int, completion: @escaping ([Video]) -> Void)
    func fetchVideo(for video: Video, completion: @escaping (AVAsset) -> Void)
}
