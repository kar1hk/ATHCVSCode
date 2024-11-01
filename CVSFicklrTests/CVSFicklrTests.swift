//
//  CVSFicklrTests.swift
//  CVSFicklrTests
//
//  Created by Karthik Sankar on 10/31/24.
//

import XCTest
@testable import CVSFicklr

// Test cases to test basic view model functionalities
final class CVSFicklrTests: XCTestCase {
    
    var viewModel: FKLPhotoViewModel!                       // Photo Stream View Model
    var mockNetworkingManager: MockCVSNetworkingManager!    // Mock Networking nManager used to do mock api calls
    
    override func setUp() async throws {
        try await super.setUp()
        
        // Create a Mock Network Manager
        mockNetworkingManager = MockCVSNetworkingManager()
        
        // Initialize the ViewModel within an async context
        // we use async as the class depend on api calls for test cases
        viewModel = await FKLPhotoViewModel(networkingManager: mockNetworkingManager)
    }
    
    // Release all allocated resources
    override func tearDown() async throws {
        try await super.tearDown()
        viewModel = nil
        mockNetworkingManager = nil
    }
           
    // MARK: - FKLPhotoViewModel Tests
        // Check if the api provided stream is what we get in View Model
        func testFetchPhotoStreamSuccess() async {
            // Make Test Data
            let mockPhotos = [
                FKLPhotoModel(title: "CVS Photo", mediaURL: "https://cadiversityawards.com/wp-content/uploads/2024/06/CVS-Health-Awardee.png"),
                FKLPhotoModel(title: "Athena Photo", mediaURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQFEmTpwlJJ9Jb8YQthS1IaZMDj8yIKt2rFAw&s")
            ]
            
            let mockResponse = FKLPhotoResponseModel(items: mockPhotos)
            mockNetworkingManager.shouldReturnError = false             // Set Error to False
            mockNetworkingManager.mockResponseData = mockResponse       // Set Valid Test Data
            
            // Sending Health as example
            await viewModel.fetchPhotoStreamFor(searchTerm: "Health")
            
            // Await and store the properties in local variables
              let isLoading = await viewModel.isLoading
              let photoStreamCount = await viewModel.photoStream.count
              let firstPhotoTitle = await viewModel.photoStream.first?.title
              
              // Assert
              XCTAssertFalse(isLoading)                     // Check loading - this needs to be false upon data retierval - State Validation
              XCTAssertEqual(photoStreamCount, 2)           // Check for Stream item count - data validation
              XCTAssertEqual(firstPhotoTitle, "CVS Photo")  // Check for title - data validation
        }
        
        // Check for Error Scenario
        // Stream is empty and Error thrown
        func testFetchPhotoStreamInvalidResponseError() async {
            // Set Error to true
            mockNetworkingManager.shouldReturnError = true
            
            // Sending random string to fail
            await viewModel.fetchPhotoStreamFor(searchTerm: "Health02394702398$")
            
            // Await and store the properties in local variables
            let isLoading = await viewModel.isLoading
            let isPhotoStreamEmpty = await viewModel.photoStream.isEmpty
            
            // Assert
            XCTAssertFalse(isLoading)               // Check loading - this needs to be false upon data retierval - State Validation
            XCTAssertTrue(isPhotoStreamEmpty)       // Check for stream - it should be empty
        }
}
