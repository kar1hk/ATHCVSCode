//
//  ContentView.swift
//  CVSFicklr
//
//  Created by Karthik Sankar on 10/31/24.
//
import SwiftUI

// Startup View
struct ContentView: View {
    // State Object to get view model
    @StateObject var viewModel = FKLPhotoViewModel()
    @Namespace private var animationNamespace // Transition Animation NameSpace for Detail Transition
    
    var body: some View {
        // Navigation Stack - as Naivgation View is deprecated
        NavigationStack {
            VStack(spacing: 0) {
                // Custom CVS Navigation Bar
                CVSUINavigationSearchBar(title: "\(CVSUIKit.shared.brandTitle) Flickr",
                                         searchText: $viewModel.searchText)
                
                // Container View that takes in
                // custom Loading View : When API call is in progress
                // Empty View : View shown when no photos are avialable
                FKLPhotoContainer(isLoading: viewModel.isLoading,
                                  photoStream: viewModel.photoStream,
                                  searchText: $viewModel.searchText,
                                  emptyView:  {
                                    Text("Type Something to Search")
                                           .font(.headline)
                                           .foregroundColor(.gray)
                                           .padding()
                                    },
                                  loadingView: {
                                    CVSUIProgressView("Searching...")
                },destination: {
                    photo in FKLPhotoDetailView(photo: photo, namespace: animationNamespace)
                }, namespace: animationNamespace)
            }
            .navigationBarHidden(true) // Hide default navigation bar
            .onAppear {
                // Reset searchText - Fallback
                viewModel.searchText = ""
            }
        }
    }
}

#Preview ("App"){
    ContentView()
}
