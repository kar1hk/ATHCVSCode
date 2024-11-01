//
//  MockCVSNetworkingManager.swift
//  CVSFicklr
//
//  Created by Karthik Sankar on 10/31/24.
//
// MockCVSNetworkingManager.swift
// Used in Test cases to mock network manager
import Foundation

class MockCVSNetworkingManager: CVSNetworkingProtocol {
    var shouldReturnError = false       // Placeholder to return error
    var mockResponseData: Any?          // Placeholder to store data
    
    // Request method that we use in tests to mock success and error based on above flags
    func request<T: Codable>(_ url: String, method: CVSHTTPMethod, body: Any?) async throws -> T {
        // Returns a Generic Error
        if shouldReturnError {
            throw CVSNetworkError.invalidResponse
        }
        
        // If data is available returns it else JSON parse error is thrown
        guard let responseData = mockResponseData as? T else {
            throw CVSNetworkError.invalidJSON
        }
        return responseData
    }
}
