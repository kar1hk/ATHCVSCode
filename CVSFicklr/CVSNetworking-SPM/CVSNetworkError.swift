//
//  CVSNetworkError.swift
//  CVSFicklr
//
//  Created by Karthik Sankar on 10/31/24.
//
// CVSNetworkError is a Enum to add Error Handling for
// CVSNetworking Manager Class

enum CVSNetworkError: String, Error {
    case invalidURL         =   "Invalid Request URL."
    case invalidRequest     =   "Invalid Request."
    case invalidResponse    =   "Bad Response."
    case invalidData        =   "Invalid Response Data."
    case invalidJSON        =   "Response Parsing Error."
    case invalidStatusCode  =   "Bad Status Code."
    case noConnectivity     =   "Check Your Connectivity."
    case timeout            =   "Request Timed Out."
    
    // Returns a meaningful message as description for the ERRors
    var description: String {
        return self.rawValue
    }
}
