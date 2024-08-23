//
//  Post.swift
//  Navigation App
//
//  Created by Matvey Krasnov on 21.8.24..
//

import UIKit

struct Post {
    let author: String
    let description: String
    let image: String
    let likes: Int
    let views: Int
}

extension Post {
    static func makePost() -> [Post] {
        [
            Post(
                author: "Stepan",
                description: "First post",
                image: "post1",
                likes: 3,
                views: 10
            ),
            Post(
                author: "Stepan",
                description: "second post",
                image: "post2",
                likes: 3,
                views: 10
            ),
            Post(
                author: "Stepan",
                description: "third post",
                image: "post3",
                likes: 3,
                views: 10
            ),
            Post(
                author: "Stepan",
                description: "forth post",
                image: "post4",
                likes: 3,
                views: 10
            )
        ]
    }
}
