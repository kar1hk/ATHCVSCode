//
//  FLRPhotoModel.swift
//  CVSFicklr
//
//  Created by Karthik Sankar on 10/31/24.
//
// FKLPhoto Model has the elements needed
// parsing response and photo elements.

// FKLPhotoModel.swift

import Foundation

// This Model is to parse the Photo objects in the JSON
struct FKLPhotoModel: Codable {
    struct Media: Codable {
        let m: String?
        
        // Computed property for a valid or default image URL
        var imageURL: String {
            return m ?? CVSUIKit.shared.brandLogoURL // Replace with Brand Logo
        }
        
        // Custom initializer for the Media struct
        init(m: String? = nil) {
            self.m = m
        }
    }
    
    let uniqueID = UUID().uuidString // Unique ID generated at initialization
    let title: String?               // Title of the photo
    let link: String?                // Link to Flickr app
    let media: Media                 // Media source
    let dateTaken: String?           // Date taken
    let description: String?         // Photo Description
    let publishedOn: String?         // Published Date
    let author: String?              // Author
    let authorID: String?            // Author ID
    let tags: String?                // Tags for the Photos
    
    enum CodingKeys: String, CodingKey {
        case title, link, media, description, author, tags
        case dateTaken      = "date_taken"
        case publishedOn    = "published"
        case authorID       = "author_id"
    }
    
    // Custom initializer for FKLPhotoModel
    init(title: String? = nil, link: String? = nil, mediaURL: String? = nil, dateTaken: String? = nil, description: String? = nil, publishedOn: String? = nil, author: String? = nil, authorID: String? = nil, tags: String? = nil) {
        self.title = title
        self.link = link
        self.media = Media(m: mediaURL)
        self.dateTaken = dateTaken
        self.description = description
        self.publishedOn = publishedOn
        self.author = author
        self.authorID = authorID
        self.tags = tags
    }
    
    // Computing a Formatted Version of Published on
    var formattedPublishedOn: String? {
        guard let publishedOn = publishedOn else { return nil }
        
        // Define the input and output date formatters
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd MMMM yyyy" // "Day Month Year"
        
        // Parse and format the date
        if let date = inputFormatter.date(from: publishedOn) {
            return outputFormatter.string(from: date)
        }
        
        return nil // Return nil if the date parsing fails
    }
}

// Extension to make FKLPhotoModel identifiable by uniqueID
extension FKLPhotoModel: Identifiable {
    var id: String {
        uniqueID
    }
}

// BONUS: Extension to extract ImageSize, returning a tuple
extension String {
    // Extracts the width and height of an image from an HTML string containing `width` and `height` attributes.
    func extractImageSize() -> (width: Int?, height: Int?) {
        // Regex passing to scan the string for image source url and then anything that matches width and height.
        // Extract 0-9 digits from ""
        let widthRegex = try? NSRegularExpression(pattern: "width=\"(\\d+)\"", options: .caseInsensitive)
        let heightRegex = try? NSRegularExpression(pattern: "height=\"(\\d+)\"", options: .caseInsensitive)
        
        // Find the first match then get the range at 1 , also once this is done convert it to a Int
        let width = widthRegex?.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count))
            .flatMap { Range($0.range(at: 1), in: self) }
            .flatMap { Int(self[$0]) }
        let height = heightRegex?.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count))
            .flatMap { Range($0.range(at: 1), in: self) }
            .flatMap { Int(self[$0]) }
        
        // Return the Tuple
        return (width, height)
    }
}
