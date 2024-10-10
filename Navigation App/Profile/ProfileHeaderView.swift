//
//  ProfileHeaderView.swift
//  Navigation App
//
//  Created by Matvey Krasnov on 12.8.24..
//

import UIKit
import SnapKit

class ProfileHeaderView : UIView {
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
    
    let fullNameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .label
        label.text = "Hipster Cat"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let someLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        label.text = "Waiting for something..."
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let statusButton : UIButton = {
        let button = UIButton()
        button.setTitle("Show status", for: .normal)
#if DEBUG
        button.backgroundColor = UIColor.black
#else
        button.backgroundColor = UIColor(named: "logoColor")
#endif
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
        self.backgroundColor = .systemBackground
        tuneView()
        setupSubviews()
        setupCinstrainsViaSnapkit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        CGSize(
            width: UIView.noIntrinsicMetric,
            height: 250.0
        )
    }
    
    func setupSubviews() {
        self.addSubview(profileImage)
        self.addSubview(fullNameLabel)
        self.addSubview(someLabel)
        self.addSubview(statusButton)
    }
    
    private func tuneView() {
        backgroundColor = .secondarySystemBackground
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func setupCinstrainsViaSnapkit() {
        profileImage.snp.makeConstraints { (make) -> Void in
            make.width.height.equalTo(130.0)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(16.0)
            make.top.equalTo(self.safeAreaLayoutGuide).offset(16.0)
        }
        fullNameLabel.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(100.0)
            make.height.equalTo(20.0)
            make.centerX.equalTo(self.safeAreaLayoutGuide).offset(16.0)
            make.top.equalTo(self.safeAreaLayoutGuide).offset(27.0)
        }
        someLabel.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(200.0)
            make.height.equalTo(20.0)
            make.leading.equalTo(snp_centerXWithinMargins).offset(-30.0)
            make.bottom.equalTo(statusButton.snp_topMargin).offset(-34.0)
        }
        statusButton.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(50.0)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(16.0)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-16.0)
            make.top.equalTo(profileImage.snp_bottomMargin).offset(16.0)
        }
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
