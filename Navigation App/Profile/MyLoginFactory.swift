//
//  MyLoginFactory.swift
//  Navigation App
//
//  Created by Matvey Krasnov on 28.10.24..
//

import UIKit

protocol LoginFactory {
    func makeLoginInspector() -> LoginInspector
}

struct MyLoginFactory: LoginFactory {
    func makeLoginInspector() -> LoginInspector {
        return LoginInspector()
    }
}
