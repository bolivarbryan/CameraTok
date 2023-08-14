//
//  GalleryView.swift
//  CameraTok
//
//  Created by Bryan A Bolivar M on 13/08/23.
//

import SwiftUI

struct GalleryView: View {
    @StateObject private var viewModel: GalleryViewModel
    @State private var isShowingCalendarPicker = false
    
    init(source: GalleryProviderSource) {
        _viewModel = StateObject(wrappedValue: GalleryViewModel(source: source))
    }
    
    var body: some View {
        ZStack {
            NavigationStack {
                VStack {
                    ScrollView {
                        LazyVGrid(columns: [.init(.adaptive(minimum: UIScreen.main.bounds.width/3, maximum: .infinity), spacing: 0)], spacing: 0) {
                            ForEach(viewModel.videos) { video in
                                GalleryThumbnail(video: video)
                                    .onAppear {
                                        if video == viewModel.lastVideo {
                                            loadMoreVideosIfNeeded()
                                        }
                                    }
                            }
                        }
                        .onAppear {
                            viewModel.fetchLastVideos()
                        }
                    }
                }
                .navigationBarTitle("CameraTok")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(trailing: DatePicker("", selection: $viewModel.selectedDate, displayedComponents: .date)
                    .datePickerStyle(CompactDatePickerStyle()))
            }
        }
    }
    
    private func loadMoreVideosIfNeeded() {
        viewModel.moveNextPage()
    }
}
