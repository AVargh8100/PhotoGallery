//
//  ImageGalleryViewModel.swift
//  PhotoGallery
//
//  Created by Alex Varghese on 14/07/24.
//

import Foundation
import Combine

enum GalleryViewStates {
    case loading(imagesList: [Item])
    case error(message: String)
}

final class ImageGalleryViewModel: ObservableObject {
    private let webServiceClient: WebServiceClientContract
    private var anyCancellable: AnyCancellable?
    let searchTextPublisher = PassthroughSubject<String, Never>()
    @Published var galleryViewStates: GalleryViewStates = .loading(imagesList: [])

    init(webServiceClient: WebServiceClientContract = WebServiceClient()) {
        self.webServiceClient = webServiceClient
        bindSearch()
    }
    private func bindSearch() {
        anyCancellable = searchTextPublisher
            .debounce(for: .milliseconds(2000), scheduler: DispatchQueue.main)
            .sink { value in
                Task {
                    await self.search(value)
                }
            }
    }
}

extension ImageGalleryViewModel {
    
    @MainActor
    func search(_ searchWord: String) async {
        do {
            let imageSearchRequest = ImageSearchRequest(path: EnvironmentUrls.searchPath, params: ["format":"json", "nojsoncallback": "1", "tags":searchWord])
            let imageData = try await     webServiceClient.restApi(imageSearchRequest, type: ImageSearchResponse.self)
            galleryViewStates = .loading(imagesList: imageData.items)
        } catch let error {
            galleryViewStates = .error(message: error.localizedDescription)
        }
    }
}


