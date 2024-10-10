//
//  Reusable.swift
//  Navigation App
//
//  Created by Matvey Krasnov on 29.8.24..
//

import UIKit

protocol ReusableView: AnyObject {
    static var identifier: String { get }
}

extension UICollectionViewCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
