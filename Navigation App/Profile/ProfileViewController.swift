//
//  ProfileViewController.swift
//  Navigation App
//
//  Created by Matvey Krasnov on 12.8.24..
//

import UIKit

class ProfileViewController: UIViewController {

    let profileHeaderView = ProfileHeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.backgroundColor = .white
        self.view.backgroundColor = .white
        self.title = "Profile"
      
        setupLayout()

        }
        func setupLayout() {
            view.addSubview(profileHeaderView)
            profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                profileHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                profileHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                profileHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                profileHeaderView.heightAnchor.constraint(equalToConstant: 220)
            ])

        }
}
