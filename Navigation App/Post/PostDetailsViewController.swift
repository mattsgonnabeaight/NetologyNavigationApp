//
//  PostDetailsViewController.swift
//  Navigation App
//
//  Created by Matvey Krasnov on 22.8.24..
//

import UIKit
import StorageService

class PostDetailsViewController: UIViewController {
        
        private var data: Post? = nil
        
        func update(model: Post) {
            data = model
            navigationItem.title = model.author
            view.backgroundColor = .systemGray
        }

}
