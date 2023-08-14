//
//  ReelViewController.swift
//  CameraTok
//
//  Created by Bryan A Bolivar M on 14/08/23.
//

import UIKit
import SwiftUI

class ReelViewController: UIViewController {
    var viewModel: ReelViewModel
    
    init(viewModel: ReelViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(viewModel)
        addGalleryToView()
    }
    
    func addGalleryToView() {
        let galleryView = ReelView(viewModel: viewModel)
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
    
}
