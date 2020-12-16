//
//  NewsFeed.swift
//  Headlines
//
//  Created by Sailaja Gorti on 12/16/20.
//

import Foundation

struct NewsFeed: Decodable {
    var articles: [Article]
}

struct Article: Decodable, Identifiable {
    var id: String {
        return title ?? "empty"
    }
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var content: String?
}


