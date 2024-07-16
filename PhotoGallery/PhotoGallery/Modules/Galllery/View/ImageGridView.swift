//
//  ImageGridView.swift
//  PhotoGallery
//
//  Created by Alex Varghese on 14/07/24.
//

import Foundation
import SwiftUI

struct ImageGridView: View {
    @ObservedObject var viewModel: ImageGalleryViewModel
    @Environment(\.horizontalSizeClass) var sizeClass
    @Namespace private var imageNamespace

    // Adjust the number of columns for landscape mode
    private var columns: [GridItem] {
        let numberOfColumns = sizeClass == .compact ? 2 : 4 // the right-side is the landscape
        return Array(repeating: .init(.flexible()), count: numberOfColumns)
    }
    
    let imagesList: [Item]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(imagesList) { imageData in
                    NavigationLink(destination: ImageGalleryDetailsView(cellData: imageData, namespace: imageNamespace)) {
                        ImageViewItem(cellData: imageData, namespace: imageNamespace)
                    }
                }
            }
        }
    }
}
