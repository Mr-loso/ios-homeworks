//
//  Post.swift
//  Navigation
//
//  Created by Арсений Корнилов on 03.05.2022.
//

import Foundation

struct Posts: Equatable {
    let author, description, pic, id, title, publishedAt: String
    var likes, views: Int
}

var dataSource: [Posts] = []
