//
//  GalleryProviderSource.swift
//  CameraTok
//
//  Created by Bryan A Bolivar M on 13/08/23.
//

import Foundation

protocol GalleryProviderSource {
    func fetchVideos(from date: Date, completion: @escaping ([Video]) -> Void) 
}
