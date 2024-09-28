//
//  PhotosTableViewCell.swift
//  Navigation App
//
//  Created by Matvey Krasnov on 25.8.24..
//

import UIKit

class PhotosTableViewCell: UITableViewCell {

    
    
    private lazy var photosBlock: UIStackView = { [unowned self] in
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.clipsToBounds = true
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 10
        let numberOfPhotosSubviews = 4
        return stackView
    }()
    
    
    private lazy var photosBlockTitle : UILabel = {
        let photosBlockTitle = UILabel()
        photosBlockTitle.translatesAutoresizingMaskIntoConstraints = false
        photosBlockTitle.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        photosBlockTitle.text = "Photos"
        return photosBlockTitle
    }()
    
    private lazy var photoContent1 : UIImageView = {
        let image = UIImage(named: "meme1")
        let imageView = ProfileAvatarRounded(image: image!)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
        return imageView
    }()
    
    private lazy var photoContent2 : UIImageView = {
        let image = UIImage(named: "meme2")
        let imageView = ProfileAvatarRounded(image: image!)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
        return imageView
    }()
    
    private lazy var photoContent3 : UIImageView = {
        let image = UIImage(named: "meme3")
        let imageView = ProfileAvatarRounded(image: image!)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
        return imageView
    }()
    
    private lazy var photoContent4 : UIImageView = {
        let image = UIImage(named: "meme4")
        let imageView = ProfileAvatarRounded(image: image!)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
        return imageView
    }()
    
    private lazy var photoData : [UIView] = [photoContent1,photoContent2,photoContent3,photoContent4]
    
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(
            style: .default,
            reuseIdentifier: reuseIdentifier
            )
        tuneView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        isHidden = false
        isSelected = false
        isHighlighted = false
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        guard let view = selectedBackgroundView else {
            return
        }
        
        contentView.insertSubview(view, at: 0)
        selectedBackgroundView?.isHidden = !selected
    }
    
    private func tuneView() {
        backgroundColor = .tertiarySystemBackground
        contentView.backgroundColor = .tertiarySystemBackground
        textLabel?.backgroundColor = .clear
        detailTextLabel?.backgroundColor = .clear
        imageView?.backgroundColor = .black
        setupViews()
        contentView.addSubview(photosBlock)
        contentView.addSubview(photosBlockTitle)
        selectionStyle = .gray
        let selectedView = UIView()
        selectedView.backgroundColor = .white
        selectedBackgroundView = selectedView
    }
    
    private func setupViews() {
        
        for i in 1...4 {
            
            photosBlock.addArrangedSubview(photoData[i-1])
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            photosBlockTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12.0),
            photosBlockTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12.0),
            photosBlockTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12.0),
            photosBlockTitle.heightAnchor.constraint(equalToConstant: 30.0),
            
            photosBlock.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12.0),
            photosBlock.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            photosBlock.topAnchor.constraint(equalTo: photosBlockTitle.bottomAnchor, constant: 12.0),
            photosBlock.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12.0),
            photosBlock.heightAnchor.constraint(equalToConstant: 90.0),
            
        ])
    }
    func update() {
    }
}
