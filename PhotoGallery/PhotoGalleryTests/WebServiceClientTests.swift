//
//  WebServiceClientTests.swift
//  PhotoGalleryTests
//
//  Created by Alex Varghese on 14/07/24.
//

import XCTest
@testable import PhotoGallery

final class WebServiceClientTests: XCTestCase {

    var webServiceClient: WebServiceClient!
    
    override func setUp() {
        webServiceClient = WebServiceClient()
    }

    override func tearDown() {
        webServiceClient = nil
    }
    
    func testInvlalidRequest() async {
        
        // when empty path and params
        let request = ImageSearchRequest(path:"", params:[:])
        
        do {
          let _ = try await webServiceClient.restApi(request, type: ImageSearchResponse.self)
        }catch {
            XCTAssertEqual(error as! WebServiceClientError, WebServiceClientError.invalidRequest)
        }
    }
}
