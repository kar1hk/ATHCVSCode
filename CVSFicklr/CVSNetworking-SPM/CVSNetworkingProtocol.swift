//
//  CVSNetworkingProtocol.swift
//  CVSFicklr
//
//  Created by Karthik Sankar on 10/31/24.
//
// CVSNetworkingProtocol.swift
// This is used to make sure NetworkingManager conforms to it
// I have made this to use Networking Manager in Unit Tests as well
import Foundation

protocol CVSNetworkingProtocol {
    // Request Method contains the basic elements for a REST request to happen
    func request<T: Codable>(_ url: String, method: CVSHTTPMethod, body: Any?) async throws -> T
}
