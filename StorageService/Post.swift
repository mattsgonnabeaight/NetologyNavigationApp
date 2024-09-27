//
//  Post.swift
//  Navigation App
//
//  Created by Matvey Krasnov on 21.8.24..
//

import UIKit

public struct Post {
    public let author: String
    public let description: String
    public let image: String
    public let likes: Int
    public let views: Int
    
    public init(author: String, description: String, image: String, likes: Int, views: Int) {
        self.author = author
        self.description = description
        self.image = image
        self.likes = likes
        self.views = views
    }
}

extension Post {
    public static func makePost() -> [Post] {
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
