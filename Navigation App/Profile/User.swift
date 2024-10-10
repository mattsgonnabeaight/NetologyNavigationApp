//
//  User.swift
//  Navigation App
//
//  Created by Matvey Krasnov on 10.10.24..
//

import UIKit

class User {
    let login: String
    let fullName: String
    let avatar: UIImage
    let status: String
    
    init(login: String, fullName: String, avatar: UIImage, status: String) {
        self.login = login
        self.fullName = fullName
        self.avatar = avatar
        self.status = status
    }
}
