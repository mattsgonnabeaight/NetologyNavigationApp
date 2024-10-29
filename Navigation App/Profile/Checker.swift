//
//  Checker.swift
//  Navigation App
//
//  Created by Matvey Krasnov on 16.10.24..
//

import Foundation

class Checker {
    private let login: String = "stepan"
    private let password: String = "123"
    
    static let shared = Checker()
    private init(){}
    
    func check(login: String, password: String) -> Bool {
        print("login, password")
        if login == self.login && password == self.password {
            return true
        } else {
            return false
        }
    }
}
