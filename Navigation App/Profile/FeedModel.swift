//
//  FeedModel.swift
//  Navigation App
//
//  Created by Matvey Krasnov on 1.12.24..
//

import UIKit

class FeedModel {
    private let desiredPassword: String = "qwerty"

    func check(word: String) -> Bool {
        if word == self.desiredPassword {
            return true
        } else {
            return false
        }
    }
}
