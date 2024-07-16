//
//  MockWebServiceClient.swift
//  PhotoGalleryTests
//
//  Created by Alex Varghese on 14/07/24.
//

import Foundation
@testable import PhotoGallery

class MockWebServiceClient: WebServiceClientContract {
    func restApi<T>(_ request: Requestable, type: T.Type) async throws -> T where T : Decodable {
        if let searchedKeyWord = request.params["tags"], searchedKeyWord.isEmpty {
            throw WebServiceClientError.apiError
        }
        return ImageSearchResponse.imageResponseData as! T
    }
}

extension ImageSearchResponse {
    static var imageResponseData: ImageSearchResponse {
        ImageSearchResponse(title:"", items: [Item(title: "", link: "", media: Media(m: ""), dateTaken: "", description: "", published: "", author: "", authorId: "", tags: "")])
    }
}
