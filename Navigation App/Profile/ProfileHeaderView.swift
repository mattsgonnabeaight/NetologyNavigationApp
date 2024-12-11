//
//  ProfileHeaderView.swift
//  Navigation App
//
//  Created by Matvey Krasnov on 12.8.24..
//

import UIKit
import SnapKit

class ProfileHeaderView : UIView {
    lazy var profileImage: UIImageView = {
        let image = UIImage(named: "profileImage")
        let profileImage = ProfileAvatarRounded(image: image!)
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(didPressProfileImage)
        )
        tap.numberOfTapsRequired = 1
        profileImage.isUserInteractionEnabled = true
        profileImage.addGestureRecognizer(tap)
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.layer.borderWidth = 3
        profileImage.layer.borderColor = UIColor.white.cgColor
        profileImage.layer.masksToBounds = true
        profileImage.cornerRadius = 65.0
        return profileImage
    }()
    
    
    let fullNameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .label
//        label.text = "Hipster Cat"
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
    
    private lazy var statusCustomButton : CustomButton = {
        let button = CustomButton(title: "show status", titleColor: .white, buttonColor: .black) { [unowned self] in
        }
        return button
    }()
    
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
        self.addSubview(statusCustomButton)
    }
    
    @objc
    private func didPressProfileImage() {
        print("Did tap Profile Image")
        launchAnimation()
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
            make.bottom.equalTo(statusCustomButton.snp_topMargin).offset(-34.0)
        }
        statusCustomButton.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(50.0)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(16.0)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-16.0)
            make.top.equalTo(profileImage.snp_bottomMargin).offset(16.0)
        }
    }

    private func launchAnimation() {
        let centerOrigin = profileImage.center
        
        CATransaction.begin()
        
        CATransaction.setCompletionBlock {
            print("Did finish CAAnimation example")
        }
        
        let animationPosition = CABasicAnimation(keyPath: #keyPath(CALayer.position))
        animationPosition.toValue = CGPoint(
            x: 2.0 * centerOrigin.x,
            y: 2.0 * centerOrigin.y
        )
        animationPosition.duration = 0.5
        animationPosition.autoreverses = false
        animationPosition.isRemovedOnCompletion = false
        animationPosition.repeatCount = 1
        animationPosition.delegate = self
        profileImage.layer.add(animationPosition, forKey: #keyPath(CALayer.position))
        
        CATransaction.commit()

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

extension ProfileHeaderView: CAAnimationDelegate {
    func animationDidStart(
        _ anim: CAAnimation
    ) {
        print("Did start CAAnimation example")
    }
    func animationDidStop(
        _ animation: CAAnimation,
        finished flag: Bool
    ) {
        print("Did finish CAAnimation example")
    }
}
