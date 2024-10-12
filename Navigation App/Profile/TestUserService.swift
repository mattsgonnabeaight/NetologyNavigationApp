//
//  TestUserService.swift
//  Navigation App
//
//  Created by Matvey Krasnov on 10.10.24..
//

import UIKit

class TestUserService: UserService {
    
    let testUser = User(login: "test", fullName: "Tester", avatar: UIImage(named: "meme1")!, status: "Testing")
    
    func authorizeUser(login: String) -> User? {
        if login == testUser.login {
            return testUser
        } else {
            return nil
        }
    }
}
