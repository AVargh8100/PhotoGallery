//
//  SearchViewStates.swift
//  PhotoGallery
//
//  Created by Alex Varghese on 14/07/24.
//

import Foundation

extension GalleryViewStates: Equatable {
    public static func == (lhs: GalleryViewStates, rhs: GalleryViewStates) -> Bool {
        switch (lhs , rhs) {
        case (.loading(let lhsItems),   .loading(let rhsItems)):
            return lhsItems.count == rhsItems.count
        case (.error(let lhsError ), .error(message: let rhsError)):
            return lhsError == rhsError
        case (.error(message: _), .loading(imagesList:_)):
            return false
        case (.loading(imagesList:_), .error(message:_)):
            return false
        }
    }
}
