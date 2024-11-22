//
//  Photo.swift
//  Navigation App
//
//  Created by Matvey Krasnov on 29.8.24..
//

import Foundation
import UIKit

struct Photo {
    let imageName: String
}

extension Photo {
    
    static func make() -> [Photo] {
        [
            Photo(
                imageName: "meme1"
            ),
            Photo(
                imageName: "meme2"
            ),
            Photo(
                imageName: "meme3"
            ),
            Photo(
                imageName: "meme4"
            ),
            Photo(
                imageName: "meme5"
            ),
            Photo(
                imageName: "meme6"
            ),
            Photo(
                imageName: "meme7"
            ),
            Photo(
                imageName: "meme8"
            ),
            Photo(
                imageName: "meme9"
            ),
            Photo(
                imageName: "meme10"
            ),
            Photo(
                imageName: "meme11"
            ),
            Photo(
                imageName: "meme12"
            ),
            Photo(
                imageName: "meme13"
            ),
            Photo(
                imageName: "meme14"
            )
        ]
    }
}

extension Photo {
    static func make() -> [UIImage] {
        var photos: [UIImage] = []
        for index in 0..<14 {
            photos.append(UIImage(named: "meme\(index + 1)")!)
        }
        return photos
    }
}
