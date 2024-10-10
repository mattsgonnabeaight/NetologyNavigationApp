//
//  PhotoCell.swift
//  Navigation App
//
//  Created by Matvey Krasnov on 29.8.24..
//

import UIKit

final class PhotoCell: UICollectionViewCell {

    private enum Constants {
        static let verticalSpacing: CGFloat = 8.0
        static let horizontalPadding: CGFloat = 16.0
        static let profileDescriptionVerticalPadding: CGFloat = 8.0
        static let imageHeight: CGFloat = 180.0
    }

    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupView()
        setupSubviews()
        setupLayouts()
    }
    
    private func setupView() {
        contentView.clipsToBounds = true
        contentView.backgroundColor = .white
    }

    private func setupSubviews() {
        contentView.addSubview(profileImageView)
    }

    private func setupLayouts() {
        NSLayoutConstraint.activate([
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            profileImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            profileImageView.heightAnchor.constraint(equalToConstant: Constants.imageHeight),
        ])
    }
    
    func setup(
        with photo: Photo
    ) {
        profileImageView.image = UIImage(named: photo.imageName)
    }
}
