//
//  LogInInspector.swift
//  Navigation App
//
//  Created by Matvey Krasnov on 27.10.24..
//

import UIKit

struct LoginInspector: LogInViewControllerDelegate  {
    func check(login: String, password: String) {
        Checker.shared.check(login: login, password: password)
        print(login, password)
    }
}
