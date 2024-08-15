//
//  ProfileHeaderView.swift
//  Navigation App
//
//  Created by Matvey Krasnov on 12.8.24..
//

import UIKit

class ProfileHeaderView: UIView {
    
    let profileBackgroundView : UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    
    
    let profileImage: UIImageView = {
        let image = UIImage(named: "profileImage")
        
        let imageView = ProfileAvatarRounded(image: image!)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.masksToBounds = true
        imageView.cornerRadius = 65.0
        
        return imageView
    }()
    
    let fullNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.text = "Hipster Cat"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let someLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        label.text = "Waiting for something..."
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let statusButton: UIButton = {
        let button = UIButton()
        button.setTitle("Show status", for: .normal)
        button.backgroundColor = .blue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(nil, action: #selector(showStatusButtonPressed), for: .touchUpInside)
        button.layer.cornerRadius = 8
        button.dropShadow()
        return button
    }()
    
    @objc func showStatusButtonPressed() {
        print("button pressed")
    }
    
    func setupContraints(view: UIView) {
        let width = UIScreen.main.bounds.width
        let safeAreaGuide = view.safeAreaLayoutGuide
        view.backgroundColor = .white
        view.addSubview(profileBackgroundView)
        profileBackgroundView.addSubview(profileImage)
        profileBackgroundView.addSubview(fullNameLabel)
        profileBackgroundView.addSubview(someLabel)
        profileBackgroundView.addSubview(statusButton)
            
            NSLayoutConstraint.activate([
                profileBackgroundView.heightAnchor.constraint(equalToConstant: 220.0),
                profileBackgroundView.widthAnchor.constraint(equalToConstant: width),
                profileBackgroundView.centerXAnchor.constraint(equalTo: safeAreaGuide.centerXAnchor),
                profileBackgroundView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
                
                profileImage.heightAnchor.constraint(equalToConstant: 130.0),
                profileImage.widthAnchor.constraint(equalToConstant: 130.0),
                profileImage.leadingAnchor.constraint(equalTo: profileBackgroundView.leadingAnchor, constant: 16.0),
                profileImage.topAnchor.constraint(equalTo: profileBackgroundView.topAnchor, constant: 16.0),
                
                fullNameLabel.heightAnchor.constraint(equalToConstant: 20.0),
                fullNameLabel.widthAnchor.constraint(equalToConstant: 100.0),
                fullNameLabel.topAnchor.constraint(equalTo: profileBackgroundView.topAnchor, constant: 27.0),
                fullNameLabel.leadingAnchor.constraint(equalTo: profileBackgroundView.centerXAnchor, constant: -30.0),
                
                someLabel.heightAnchor.constraint(equalToConstant: 20.0),
                someLabel.widthAnchor.constraint(equalToConstant: 200.0),
                someLabel.bottomAnchor.constraint(equalTo: statusButton.topAnchor, constant: -34.0),
                someLabel.leadingAnchor.constraint(equalTo: profileBackgroundView.centerXAnchor, constant: -30.0),
                
                statusButton.heightAnchor.constraint(equalToConstant: 50),
                statusButton.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 16.0),
                statusButton.leadingAnchor.constraint(equalTo: profileBackgroundView.leadingAnchor, constant: 16.0),
                statusButton.trailingAnchor.constraint(equalTo: profileBackgroundView.trailingAnchor, constant: -16.0),
            ])
        }
        
        
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension UIView {

    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.7
        layer.shadowOffset = CGSize(width: 4, height: 4)
        layer.shadowRadius = 4

        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
      }

}

class ProfileAvatarRounded: UIImageView {
    var cornerRadius: CGFloat = 10.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    override var intrinsicContentSize: CGSize {
        CGSize(
            width: cornerRadius * 2,
            height: cornerRadius * 2 
        )
    }
}