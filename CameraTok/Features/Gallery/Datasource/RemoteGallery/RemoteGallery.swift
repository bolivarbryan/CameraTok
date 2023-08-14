//
//  RemoteGallery.swift
//  CameraTok
//
//  Created by Bryan A Bolivar M on 13/08/23.
//

import Foundation
import AVFoundation
import Photos

protocol RemoteGallery: GalleryProviderSource {}

struct RemoteGalleryImplementation: RemoteGallery {
    func fetchVideos(from date: Date) -> [Video] {
        return []
    }
    
    func fetchVideos(from date: Date, completion: @escaping ([Video]) -> Void) {
        requestVideoGalleryAccess { granted in
            if granted {
                self.fetchVideos(date: date) { assets in
                    var videos: [Video] = []
                    
                    var assetLoadCount = 0
                    for asset in assets {
                        let targetSize = CGSize(width: 150, height: 150)
                        let imgoptions = PHImageRequestOptions()
                        imgoptions.deliveryMode = .highQualityFormat
                        imgoptions.isNetworkAccessAllowed = true
                        imgoptions.resizeMode = .fast
                        PHImageManager.default().requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFill, options: imgoptions) { image, info in
                            let video = Video(from: asset)
                            video.previewImage = image
                            videos.append(video)
                            assetLoadCount += 1
                            if assetLoadCount == 15 {
                                completion(videos)
                            }
                        }
                    }
                }
            } else {
                print("Photo library access denied.")
            }
        }
    }
    
    func requestVideoGalleryAccess(completion: @escaping (Bool) -> Void) {
        switch PHPhotoLibrary.authorizationStatus() {
        case .authorized:
            completion(true)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { status in
                if status == .authorized {
                    completion(true)
                } else {
                    completion(false)
                }
            }
        case .denied, .restricted:
            completion(false)
        case .limited:
            completion(true)
        @unknown default:
            completion(false)
        }
    }
    
    func fetchVideos(date: Date, completion: @escaping ([PHAsset]) -> Void) {
        let fetchOptions = PHFetchOptions.fetchOptionsForVideos(limit: 15, sortBy: "creationDate", date: date)
        let fetchResult = PHAsset.fetchAssets(with: .video, options: fetchOptions)
        var phAssets: [PHAsset] = []

        fetchResult.enumerateObjects { phAsset, _, _ in
            phAssets.append(phAsset)
        }
        
        completion(phAssets)
        /*
        for asset in phAssets {
            let targetSize = CGSize(width: 100, height: 100) // Set your desired thumbnail size
            let imgoptions = PHImageRequestOptions()
            imgoptions.deliveryMode = .fastFormat // Request a lower quality thumbnail
            imgoptions.isNetworkAccessAllowed = true
            
            PHImageManager.default().requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFill, options: imgoptions) { image, info in
                print("+++++++++++++++++++", image)
            }
        }
        */
        
        /*
        for asset in phAssets {
            let options = PHVideoRequestOptions()
            options.deliveryMode = .fastFormat
            options.isNetworkAccessAllowed = true
            PHImageManager.default().requestAVAsset(forVideo: asset, options: options) { avAsset, _, _ in
                guard let avAsset = avAsset else {
                    return
                }
                let video = Video(date: avAsset.creationDate?.startDate ?? Date(),
                                  metadata: avAsset.description,
                                  asset: avAsset)
                print(video)
            }
        }
         */
    }
}

extension PHFetchOptions {
    static func fetchOptionsForVideos(limit: Int = 15, sortBy endDateKey: String = "creationDate", date: Date) -> PHFetchOptions {
        let options = PHFetchOptions()
        options.fetchLimit = limit
        options.sortDescriptors = [NSSortDescriptor(key: endDateKey, ascending: false)]
        options.predicate = NSPredicate(format: "mediaType = %d AND creationDate <= %@", PHAssetMediaType.video.rawValue, date.startOfDay as NSDate)
        return options
    }
}

extension Date {
  var startOfDay : Date {
    let calendar = Calendar.current
    let unitFlags = Set<Calendar.Component>([.year, .month, .day])
    let components = calendar.dateComponents(unitFlags, from: self)
    return calendar.date(from: components)!
  }
}
