//
//  PhotosViewController.swift
//  Navigation App
//
//  Created by Matvey Krasnov on 29.8.24..
//

import UIKit

class PhotosViewController: UIViewController {
    
    var photos: [Photo] = Photo.make()
    
    private lazy var collectionView: UICollectionView = {
            let viewLayout = UICollectionViewFlowLayout()
            
            let collectionView = UICollectionView(
                frame: .zero,
                collectionViewLayout: viewLayout
            )
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            collectionView.backgroundColor = .systemBackground
            
            collectionView.register(
                PhotoCell.self,
                forCellWithReuseIdentifier: PhotoCell.identifier
            )
        return collectionView
       }()
        override func viewDidLoad() {
            super.viewDidLoad()
            setupView()
            setupSubviews()
            setupLayouts()
        }
        
        private func setupView() {
            view.backgroundColor = .systemBackground
            title = "Photo Gallery"
        }

        private func setupSubviews() {
            setupCollectionView()
        }
        
        private func setupCollectionView() {
            view.addSubview(collectionView)
            
            collectionView.dataSource = self
            collectionView.delegate = self
        }

        private func setupLayouts() {
            let safeAreaGuide = view.safeAreaLayoutGuide
            
            NSLayoutConstraint.activate([
                collectionView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
                collectionView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
                collectionView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
                collectionView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor)
            ])
        }
        
        private enum LayoutConstant {
            static let spacing: CGFloat = 56.0
            static let itemHeight: CGFloat = 300.0
        }
    }


    extension PhotosViewController: UICollectionViewDataSource {
        
        func collectionView(
            _ collectionView: UICollectionView,
            numberOfItemsInSection section: Int
        ) -> Int {
            photos.count
        }

        func collectionView(
            _ collectionView: UICollectionView,
            cellForItemAt indexPath: IndexPath
        ) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PhotoCell.identifier,
                for: indexPath) as! PhotoCell
            
            let photo = photos[indexPath.row]
            cell.setup(with: photo)
            
            return cell
        }
    }


    extension PhotosViewController: UICollectionViewDelegateFlowLayout {
        
        private func itemWidth(
            for width: CGFloat,
            spacing: CGFloat
        ) -> CGFloat {
            let itemsInRow: CGFloat = 4
            
            let totalSpacing: CGFloat = 2 * spacing + (itemsInRow - 1) * spacing
            let finalWidth = (width - totalSpacing) / itemsInRow
            
            return floor(finalWidth)
        }
        
        func collectionView(
            _ collectionView: UICollectionView,
            layout collectionViewLayout: UICollectionViewLayout,
            sizeForItemAt indexPath: IndexPath
        ) -> CGSize {
            let width = itemWidth(
                for: view.frame.width,
                spacing: 8
            )
            
            return CGSize(width: width, height: width)
        }

        func collectionView(
            _ collectionView: UICollectionView,
            layout collectionViewLayout: UICollectionViewLayout,
            insetForSectionAt section: Int
        ) -> UIEdgeInsets {
            UIEdgeInsets(
                top: 8,
                left: 8,
                bottom: 8,
                right: 8
            )
        }

        func collectionView(
            _ collectionView: UICollectionView,
            layout collectionViewLayout: UICollectionViewLayout,
            minimumLineSpacingForSectionAt section: Int
        ) -> CGFloat {
            8
        }

        func collectionView(
            _ collectionView: UICollectionView,
            layout collectionViewLayout: UICollectionViewLayout,
            minimumInteritemSpacingForSectionAt section: Int
        ) -> CGFloat {
            8
        }
        
        func collectionView(
            _ collectionView: UICollectionView,
            didSelectItemAt indexPath: IndexPath
        ) {
            print("Did select cell at \(indexPath.row)")
            _ = photos[indexPath.row]
            let viewController = UIViewController()
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
