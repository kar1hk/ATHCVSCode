//
//  CVSNetworkingManager.swift
//  CVSFicklr
//
//  Created by Karthik Sankar on 10/31/24.
//
// CVSNetworking Manager is a singleton class
// Helps in handling HTTP requests

import Foundation

public class CVSNetworkingManager: CVSNetworkingProtocol {
    
    // Singleton Shared Instance
    static let shared = CVSNetworkingManager()
    
    // Private Init to make sure this is not called
    private init() {}
    
    /**
     request<T: Codable>(_ url:String,method:CVSHTTPMethod,body:Any) -> T
     - parameter url: Request URL
     - parameter method: CVSHTTP Method
     - parameter body: Request Body
     - returns:T Object
     */
    func request<T: Codable>(_ url: String,
                             method: CVSHTTPMethod,
                             body: Any?) async throws -> T {
        do {
            // Check for request URL
            guard let url = URL(string: url) else { throw CVSNetworkError.invalidURL }
            // Get the response and data
            let (data, response) = try await URLSession.shared.data(from: url)
            // Check for valid response and status code
            // Any status code that does not fall between 200 and 300 is considered as Bad Request
            // https://developer.mozilla.org/en-US/docs/Web/HTTP/Status - Reference
            guard let httpResponse = response as? HTTPURLResponse else { throw CVSNetworkError.invalidResponse }
            guard httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 else { throw CVSNetworkError.invalidStatusCode }
            // Parse data
            guard let parsedResponse = try? JSONDecoder().decode(T.self, from: data) else { throw CVSNetworkError.invalidJSON }
            // Returns parsed object T
            return parsedResponse
        } catch {
            // Handle specific network errors like no internet connection , request time out and deafult invalid response
            if (error as NSError).code == NSURLErrorNotConnectedToInternet {
                throw CVSNetworkError.noConnectivity
            } else if (error as NSError).code == NSURLErrorTimedOut {
                throw CVSNetworkError.timeout
            } else {
                throw CVSNetworkError.invalidResponse
            }
        }
    }
}
