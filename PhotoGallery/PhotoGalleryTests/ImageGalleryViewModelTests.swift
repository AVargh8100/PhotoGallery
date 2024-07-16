//
//  ImageGalleryViewModelTests.swift
//  PhotoGalleryTests
//
//  Created by Alex Varghese on 14/07/24.
//

import Foundation
import XCTest
@testable import PhotoGallery

final class ImageGalleryViewModelTests: XCTestCase {

    var viewModel: ImageGalleryViewModel!
    let webServiceClient: WebServiceClientContract = MockWebServiceClient()
    
    override func setUp() {
        viewModel = ImageGalleryViewModel(webServiceClient: webServiceClient)
    }

    override func tearDown() {
        viewModel = nil
    }
    
    func test_search_success_validUrl() async {
        
        // Given
        XCTAssertEqual(viewModel.galleryViewStates, .loading(imagesList: []))
        // When
        await viewModel.search("mockUrl")
        // Then
        XCTAssertEqual(viewModel.galleryViewStates, .loading(imagesList: ImageSearchResponse.imageResponseData.items))
    }
    
    func test_search_success_invalidUrl() async {
        
        // Given
        XCTAssertEqual(viewModel.galleryViewStates, .loading(imagesList: []))
        // When
        await viewModel.search("")
        // Then
        XCTAssertEqual(viewModel.galleryViewStates, .error(message:WebServiceClientError.apiError.localizedDescription))
    }
}

