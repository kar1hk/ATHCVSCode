//
//  FKLPhotoContainer.swift
//  CVSFicklr
//
//  Created by Karthik Sankar on 10/31/24.
//
// FKLPhotoContainer view lists the photo list
// And Manages the views
import SwiftUI

// This View is the Apps Container View which houses the
// Body of the App - Photo Stream
struct FKLPhotoContainer<EmptyView: View, LoadingView: View, DestinationView: View>: View {
    
    // State variables
    let isLoading: Bool                 // Loading State
    let photoStream: [FKLPhotoModel]    // Array of photos to display
    @Binding var searchText: String     // Search Text
    
    // Views provided via ViewBuilder
    @ViewBuilder var emptyView: EmptyView           // Empty View - Shown when no Photos are available
    @ViewBuilder var loadingView: LoadingView       // Loading View - Shown when API call is in progress
    
    let destination: (FKLPhotoModel) -> DestinationView     // Closure for navigation destination
    var namespace: Namespace.ID                            // Namespace for Transition Animation


    var body: some View {
        ZStack {
            // Show empty view if there's no content and loading is not in progress
            if (searchText.count == 0 || photoStream.isEmpty) && !isLoading {
                emptyView
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center) // Align empty view to top
            }
            
            // Show main content if there's content available
            if !photoStream.isEmpty {
                ScrollView {
                      LazyVStack {
                          ForEach(photoStream) { photo in
                              NavigationLink(destination: destination(photo)) {
                                  CVSUICardView(imageURL: photo.media.imageURL, title: photo.title ?? "")
                                    .matchedGeometryEffect(id: photo.id, in: namespace)
                              }
                              .buttonStyle(PlainButtonStyle())
                          }
                      }
                      .padding(.horizontal)
                  }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top) // Align content to top
            }
            
            // Show loading view if loading is in progress
            if isLoading {
                loadingView
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center) // Align content to top
            }
        }
    }
}
