//
//  ProfileHeaderView.swift
//  Navigation App
//
//  Created by Matvey Krasnov on 12.8.24..
//

import UIKit

class ProfileHeaderView: UIView {
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
        button.backgroundColor = UIColor(named: "logoColor")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(nil, action: #selector(showStatusButtonPressed), for: .touchUpInside)
        button.layer.cornerRadius = 8
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowOpacity = 0.7
        return button
    }()
    
    @objc func showStatusButtonPressed() {
        print("button pressed")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupSubviews()
        setupContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews() {
        self.addSubview(profileImage)
        self.addSubview(fullNameLabel)
        self.addSubview(someLabel)
        self.addSubview(statusButton)
    }
    
    func setupContraints() {
        
        
        NSLayoutConstraint.activate([
            profileImage.heightAnchor.constraint(equalToConstant: 130.0),
            profileImage.widthAnchor.constraint(equalToConstant: 130.0),
            profileImage.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16.0),
            profileImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16.0),
            
            fullNameLabel.heightAnchor.constraint(equalToConstant: 20.0),
            fullNameLabel.widthAnchor.constraint(equalToConstant: 100.0),
            fullNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 20.0),
            fullNameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 27.0),

            someLabel.heightAnchor.constraint(equalToConstant: 20.0),
            someLabel.widthAnchor.constraint(equalToConstant: 200.0),
            someLabel.bottomAnchor.constraint(equalTo: statusButton.topAnchor, constant: -34.0),
            someLabel.leadingAnchor.constraint(equalTo: self.centerXAnchor, constant: -30.0),
                
            statusButton.heightAnchor.constraint(equalToConstant: 50),
            statusButton.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 16.0),
            statusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.0),
            statusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16.0),
            ])
        }
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
