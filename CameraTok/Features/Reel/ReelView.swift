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

struct ReelView: View {
    @StateObject private var viewModel: GalleryViewModel
    @State private var isLiked = false
    @State private var isMuted = false
    @State private var isAnimating = false

    init(viewModel: GalleryViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
            ZStack {
                Rectangle()
                    .fill(Color.white)
                    .frame(height: UIScreen.main.bounds.height)
                VStack {
                    HStack {
                        Button(action: {
                            viewModel.mode = .gallery
                        }, label: {
                            Image(systemName: "xmark")
                                .resizable()
                                .frame(width: 15, height: 15)
                                .padding()
                                .foregroundColor(.black)
                                .background(Circle().foregroundColor(.gray))
                        })

                        Spacer()
                    }
                    .frame(height: 20)
                    .padding(.top)
                    
                    Spacer()
                   
                    HStack(alignment: .bottom) {
                        VStack {
                            Spacer()
                 
                            Button {
                                isMuted.toggle()
                            } label: {
                                
                                Image(systemName: isMuted ? "speaker.slash.fill" : "speaker.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                                    .padding()
                                    .foregroundColor(.black)
                                    .background(
                                        Circle().foregroundColor(.gray)
                                            .scaleEffect((isAnimating && !isMuted) ? 1.1 : 1.0)
                                            .animation(.easeInOut.repeatForever(autoreverses: true), value: 0.1)
                                    )
                                
                            }
                        }
                        .onAppear {
                                    startBeatAnimation()
                                }
                        Spacer()
                        VStack {
                            Spacer()
                            Image(systemName: "hand.thumbsdown")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .padding()
                                .foregroundColor(.black)
                                .background(Circle().foregroundColor(.gray))
                            
                            Button {
                                isLiked.toggle()
                            } label: {
                                Image(systemName: isLiked ? "heart.fill" : "heart")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                                    .padding()
                                    .foregroundColor(.black)
                                    .background(Circle().foregroundColor(.gray))
                                    .rotationEffect(Angle(degrees: isLiked ? 360 : 0))
                            }
                        }
                    }
                    .frame(height: 100)
                    .padding(.bottom, 20)
                }
                .padding(.vertical, 40)
                .padding(.horizontal, 20)
        }
    }
    
    func startBeatAnimation() {
        let beatInterval = 0.3
        let timer = Timer.scheduledTimer(withTimeInterval: beatInterval, repeats: true) { _ in
            withAnimation {
                isAnimating.toggle()
            }
        }
        timer.fire()
    }
}

struct VideoPlayerView: View {
    @State var asset: AVAsset?
    @State var video: Video

    var body: some View {
        if let asset = asset {
            VideoPlayer(player: AVPlayer(playerItem: AVPlayerItem(asset: asset))) {
                // You can customize the player controls and overlay here
            }
            .onAppear { }
            .onDisappear {
                // Implement pause or other actions when the view disappears if needed
            }
        } else {
            EmptyView()
        }
    }
}
