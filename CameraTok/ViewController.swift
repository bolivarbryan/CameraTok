//
//  ViewController.swift
//  CameraTok
//
//  Created by Bryan A Bolivar M on 13/08/23.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    let viewModel = GalleryViewModel(source: RemoteGalleryImplementation())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGalleryToView()
    }
    
    func addGalleryToView() {
        let galleryView = GalleryView(source: RemoteGalleryImplementation())
        let galleryVC = UIHostingController(rootView: galleryView)
        addChild(galleryVC)
        view.addSubview(galleryVC.view)
        galleryVC.view.translatesAutoresizingMaskIntoConstraints = false
        galleryVC.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        galleryVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        galleryVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        galleryVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        galleryVC.didMove(toParent: self)
    }
    
    func presentCalendarPicker() {
        
    }
}

