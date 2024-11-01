//
//  FKLPhotoViewModel.swift
//  CVSFicklr
//
//  Created by Karthik Sankar on 10/31/24.
//
// FKLPhotoViewModel
// used to contain the business logic for
// Photo View App
import Combine
import Foundation

// Main Actor - Access Main Thread for UI Updates
// View Model
@MainActor class FKLPhotoViewModel: ObservableObject {
    
    // Photo data that feeds the dashboard
    @Published var photoStream : [FKLPhotoModel] = [FKLPhotoModel]()
    
    // Search String
    @Published var searchText: String = "" {
           didSet {
               // Trim whitespace and check if searchText is empty
               let trimmedText = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
               
               guard !trimmedText.isEmpty else {
                   photoStream.removeAll()
                   return // Do nothing if searchText is empty or only contains spaces
               }
               // Handle this in background Async Call
               Task {
                   await fetchPhotoStreamFor(searchTerm: trimmedText)
               }
           }
    }
    
    // Boolean for network connectivity handling
    @Published var isNetworkAvailable: Bool = true
    
    // Loading Toggle
    @Published var isLoading: Bool = false // Tracks the loading state
    
    // Network Manager Protocol
    private var networkingManager: CVSNetworkingProtocol
    
    // Initialize with a custom networking manager for testing
    // Dependency Injection
    init(networkingManager: CVSNetworkingProtocol = CVSNetworkingManager.shared) {
        self.networkingManager = networkingManager
    }
    
    // Fetch Photo Stream by doing a network call and handle errors gracefully
    func fetchPhotoStreamFor(searchTerm: String) async {
        isLoading = true // Show the progress indicator
        
        do {
            let photoDataResponse: FKLPhotoResponseModel = try await networkingManager.request(getURLForSearchTerm(searchTerm), method: .GET, body: nil)
            photoStream = photoDataResponse.items
            isLoading = false // Hide the progress indicator
        }
        catch CVSNetworkError.invalidResponse {
            print("Invalid Response")
            isLoading = false // Hide the progress indicator
        }
        catch CVSNetworkError.noConnectivity {
            isNetworkAvailable = false
            isLoading = false // Hide the progress indicator
            print("No Connectivity")
        }
        catch {
            isLoading = false // Hide the progress indicator
            print("Unknown Error")
        }
    }
}

// Load all App related settings
extension FKLPhotoViewModel {
    
    // Get URL String for search term
    func getURLForSearchTerm(_ searchTerm: String) -> String {
        return "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags=\(searchTerm)"
    }
}
