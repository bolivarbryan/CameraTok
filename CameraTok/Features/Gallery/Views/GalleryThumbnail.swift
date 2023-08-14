//
//  GalleryThumbnail.swift
//  CameraTok
//
//  Created by Bryan A Bolivar M on 13/08/23.
//

import SwiftUI

struct GalleryThumbnail: View {
    var video: Video
    
    var body: some View {
        Image(uiImage: video.previewImage ?? UIImage())
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .clipped()
            .aspectRatio(1, contentMode: .fit)
    }
}
