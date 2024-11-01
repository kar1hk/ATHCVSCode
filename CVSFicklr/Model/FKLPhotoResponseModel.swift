//
//  FKLPhotoResponseModel.swift
//  CVSFicklr
//
//  Created by Karthik Sankar on 10/31/24.
//
// FKLPhotoResponseModel acts as a json object for the
// entire response

import Foundation

// This Model is to parse the Response from the Flickr API
struct FKLPhotoResponseModel: Codable {
    let title: String?          // Title
    let link: String?           // Link to Flickr App
    let description: String?    // Description
    let modifiedOn: String?     // Date Modified
    let source: String?         // Generator Source
    let items: [FKLPhotoModel]  // Items of photos in array
    
    enum CodingKeys: String, CodingKey {
        case title, link, description, items
        case modifiedOn  = "modified"
        case source      = "generator"
    }
    
    // Existing initializer for decoding from JSON
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        link = try container.decodeIfPresent(String.self, forKey: .link)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        modifiedOn = try container.decodeIfPresent(String.self, forKey: .modifiedOn)
        source = try container.decodeIfPresent(String.self, forKey: .source)
        items = try container.decode([FKLPhotoModel].self, forKey: .items)
    }
    
    // Custom initializer for testing
    init(title: String? = nil, link: String? = nil, description: String? = nil, modifiedOn: String? = nil, source: String? = nil, items: [FKLPhotoModel] = []) {
        self.title = title
        self.link = link
        self.description = description
        self.modifiedOn = modifiedOn
        self.source = source
        self.items = items
    }
}
