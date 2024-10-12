//
//  UserService.swift
//  Navigation App
//
//  Created by Matvey Krasnov on 10.10.24..
//

import UIKit

protocol UserService {
    func authorizeUser(login: String) -> User?
}
