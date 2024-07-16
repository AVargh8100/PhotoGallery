//
//  ImageSearchResponse.swift
//  PhotoGallery
//
//  Created by Alex Varghese on 14/07/24.
//

import Foundation

// MARK: - ImageSearchResponse
struct ImageSearchResponse: Decodable {
    let title: String
    let items: [Item]
}

// MARK: - Item
struct Item: Decodable {
    let title: String
    let link: String
    let media: Media
    let dateTaken: String
    let description,published: String
    let author, authorId, tags: String
}

extension Item: Identifiable {
    var id: String {
        return dateTaken
    }
}

// MARK: - Media
struct Media: Decodable {
    let m: String
}
