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
        view.frame = CGRect(
                x: 0.0,
                y: 90.0,
                width: 1000.0,
                height: 1000.0
        )
        return view
    }()
    
    let profileImage: UIImageView = {
        //let imageName = "profileImage"
        let image = UIImage(named: "profileImage")
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(
                x: 16.0,
                y: 116.0,
                width: 130.0,
                height: 130.0
        )
        imageView.layer.borderWidth = 3
        imageView.layer.masksToBounds = true
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = imageView.frame.height/2
        return imageView
    }()
    
    let fullNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.text = "Hipster Cat"
        label.numberOfLines = 0
        //label.translatesAutoresizingMaskIntoConstraints = false
        label.frame = CGRect(
            origin: CGPoint(
                        x: 165.0,
                        y: 127.0
                    ),
                    size: CGSize(
                        width: 150.0,
                        height: 50.0
                    )
        )
        return label
    }()
    
    let someLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        label.text = "Waiting for something..."
        label.numberOfLines = 0
        //label.translatesAutoresizingMaskIntoConstraints = false
        label.frame = CGRect(
            origin: CGPoint(
                        x: 165.0,
                        y: 177.0
                    ),
                    size: CGSize(
                        width: 250.0,
                        height: 50.0
                    )
        )
        return label
    }()
    
    let statusButton: UIButton = {
        let button = UIButton()
        button.setTitle("Show status", for: .normal)
        button.backgroundColor = .blue
        button.addTarget(nil, action: #selector(showStatusButtonPressed), for: .touchUpInside)
        button.frame = CGRect(
            origin: CGPoint(
                        x: 16.0,
                        y: 282.0
                    ),
                    size: CGSize(
                        width: 350.0,
                        height: 50.0
                    )
        )
        button.layer.cornerRadius = 8
        button.dropShadow()
        return button
    }()
    
    @objc func showStatusButtonPressed() {
        print("button pressed")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(profileBackgroundView)
        addSubview(profileImage)
        addSubview(fullNameLabel)
        addSubview(someLabel)
        addSubview(statusButton)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
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
