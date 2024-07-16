//
//  ImageSearchRequest.swift
//  PhotoGallery
//
//  Created by Alex Varghese on 14/07/24.
//

import Foundation

struct ImageSearchRequest: Requestable {
    var path: String
    var params: [String : String]
    init(path: String, params: [String : String]) {
        self.path = path
        self.params = params
    }
}
