//
//  ReelView.swift
//  CameraTok
//
//  Created by Bryan A Bolivar M on 14/08/23.
//

import SwiftUI
import AVFoundation
import AVKit
import Photos

/*
struct ReelView: View {
    @StateObject private var viewModel: ReelViewModel
    
    init(viewModel: ReelViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack {
            ScrollViewReader { scrollViewProxy in
                ScrollView {
                    LazyVGrid(columns: [.init(.adaptive(minimum: UIScreen.main.bounds.width, maximum: .infinity), spacing: 0)], spacing: 0) {
                        ForEach(viewModel.videos) { video in
                            AVPlayerView(player: AVPlayer(playerItem: AVPlayerItem(asset: viewModel.videoAsset)))
                                .frame(height: UIScreen.main.bounds.height)
                                .onAppear() {
                                    viewModel.fetchVideoAsset { }
                                }
                                .onDisappear() {
                                    viewModel.videoAsset
                                }
                        }
                    }
                    .onAppear() {
                        scrollViewProxy.scrollTo(viewModel.currentPage, anchor: .center)
                    }
                }
            }
        }
    }
}
*/

struct ReelView: View {
    @StateObject private var viewModel: ReelViewModel
    
    init(viewModel: ReelViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    ForEach(viewModel.videos) { asset in
                        VideoPlayerView(asset: viewModel.videoAsset)
                            .frame(height: UIScreen.main.bounds.height)

                    }
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

struct VideoPlayerView: View {
    let asset: AVAsset

    var body: some View {
        VideoPlayer(player: AVPlayer(playerItem: AVPlayerItem(asset: asset))) {
            // You can customize the player controls and overlay here
        }
        .onAppear {
            // Implement autoplay logic here if needed
        }
        .onDisappear {
            // Implement pause or other actions when the view disappears if needed
        }
    }
}

/*

import SwiftUI
import AVKit

struct AVPlayerView: UIViewControllerRepresentable {

    let player: AVPlayer

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        playerViewController.player?.play()
        return playerViewController
    }

    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        
    }
    
}
*/
