//
//  CurrentUserService.swift
//  Navigation App
//
//  Created by Matvey Krasnov on 10.10.24..
//

import UIKit

class CurrentUserService: UserService {
    
    let user: User
    
    func authorizeUser(login: String) -> User? {
        if login == user.login {
            return user
        } else {
            return nil
        }
    }
    
    init(user: User) {
        self.user = user
    }
}
