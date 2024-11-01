//
//  FKLPhotoDetailView.swift
//  CVSFicklr
//
//  Created by Karthik Sankar on 10/31/24.
//
// FKLPhotoDetailView view gives details on the
// Photo selected
import SwiftUI

struct FKLPhotoDetailView: View {
    
    let photo: FKLPhotoModel            // Photo Element
    var namespace: Namespace.ID         // Namespace for matchedGeometryEffect

    // BONUS: Extract width and height from Photo Object to display
    var imageSize: (width: Int?, height: Int?) {
        photo.description?.extractImageSize() ?? (nil, nil)
    }

    var body: some View {
        VStack {
            // Top Hero Image
            AsyncImage(url: URL(string: photo.media.imageURL)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .matchedGeometryEffect(id: photo.id, in: namespace)
                        .frame(maxWidth: .infinity, maxHeight: 300)
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.gray)
                        .matchedGeometryEffect(id: photo.id, in: namespace)
                        .frame(maxWidth: .infinity, maxHeight: 300)
                @unknown default:
                    EmptyView()
                }
            }
            // Title with Fallback
            Text(photo.title ?? "Untitled")
                .font(.largeTitle)
                .padding(.top)
            
            // Display author and published date
            if let author = photo.author, !author.isEmpty {
                Text("By \(author)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.top, 2)
            }
            
            // Published On Date
            if let publishedOn = photo.formattedPublishedOn, !publishedOn.isEmpty {
                Text("Published on \(publishedOn)")
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .padding(.top, 1)
            }
            
            // Display image dimensions if available
            if let width = imageSize.width, let height = imageSize.height {
                Text("Image size: \(width) x \(height)")
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .padding(.top, 2)
            }
            
            // Raw Text Description
            // TODO: this can be loaded in Web View or converted to raw text
            Text(photo.description ?? "No description available")
                .font(.body)
                .padding(.top, 5)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Photo Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
