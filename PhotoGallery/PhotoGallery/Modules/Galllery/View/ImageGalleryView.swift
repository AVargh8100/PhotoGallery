//
//  ContentView.swift
//  PhotoGallery
//
//  Created by Alex Varghese on 14/07/24.
//

import SwiftUI

struct ImageGalleryView: View {
    @StateObject var viewModel = ImageGalleryViewModel()
    @State var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            searchView()
                .searchable(text: $searchText,
                            placement: .automatic,
                            prompt: "Search")
                .onChange(of: searchText, initial: true) { searchText, newVlaue in
                    viewModel.searchTextPublisher.send(newVlaue)
                }
                .navigationTitle("Home")
        }
    }
    
    @ViewBuilder
    private func searchView() -> some View {
        switch viewModel.galleryViewStates {
        case .loading(let imagesList):
            ImageGridView(viewModel:viewModel, imagesList: imagesList)
            
        case .error(let message):
            Text(message)
                .padding()
        }
    }
}


#Preview {
    ImageGalleryView()
}
