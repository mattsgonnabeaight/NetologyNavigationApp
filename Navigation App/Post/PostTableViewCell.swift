//
//  PostTableViewCell.swift
//  Navigation App
//
//  Created by Matvey Krasnov on 22.8.24..
//

import UIKit
import StorageService
//No such module 'iOSIntPackage'
import iOSIntPackage


class PostTableViewCell: UITableViewCell {
    private lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .label
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var postImage : UIImageView = {
        let image = UIImage(named: "profileImage")
        //как это определять и запускать? xcode ругается на отсутствие снепкита, 
        image.processImage(sourceImage: image, filter: .noir, completion: self)
        let imageView = UIImageView(image: image!)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
        return imageView
    }()
    
    private lazy var postText: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .systemGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .systemBackground
        return label
    }()
    
    private lazy var likes: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .label
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .systemBackground
        label.text = "Likes: "
        return label
    }()
    
    private lazy var views: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .label
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .systemBackground
        label.text = "Views: "
        return label
    }()


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
        contentView.addSubview(fullNameLabel)
        contentView.addSubview(postImage)
        contentView.addSubview(postText)
        contentView.addSubview(likes)
        contentView.addSubview(views)
        selectionStyle = .gray
        let selectedView = UIView()
        selectedView.backgroundColor = .white
        selectedBackgroundView = selectedView
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            fullNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            fullNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            fullNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16.0),
            fullNameLabel.heightAnchor.constraint(equalToConstant: 30.0),
            
            postImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postImage.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor),
            postImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -100.0),
            postImage.heightAnchor.constraint(equalToConstant: 400),
            
            postText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postText.topAnchor.constraint(equalTo: postImage.bottomAnchor),
            postText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16.0),
            postText.heightAnchor.constraint(equalToConstant: 50.0),
            
            likes.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            likes.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16.0),
            likes.heightAnchor.constraint(equalToConstant: 30.0),
            likes.widthAnchor.constraint(equalToConstant: 70.0),
            
            views.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            views.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16.0),
            views.heightAnchor.constraint(equalToConstant: 30.0),
            views.widthAnchor.constraint(equalToConstant: 90.0),
        ])
    }
    
    func update(_ model: Post) {
        fullNameLabel.text = model.author
        postImage.image = UIImage(named: model.image)
        postText.text = model.description
        likes.text! += String(model.likes)
        views.text! += String(model.views)
    }

}
