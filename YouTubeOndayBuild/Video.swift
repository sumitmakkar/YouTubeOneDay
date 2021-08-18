//
//  Video.swift
//  YouTubeOndayBuild
//
//  Created by Sumit Makkar on 17/08/21.
//

import Foundation

struct Video: Decodable
{
    var videoId     = ""
    var title       = ""
    var description = ""
    var thumbnail   = ""
    var published   = Date()
    
    enum CodingKeys: String, CodingKey
    {
        case snippet
        case thumbnails
        case high
        case resourceId
        
        case videoId
        case title
        case description
        case thumbnail = "url"
        case published = "publishedAt"
    }
    
    init(from decoder: Decoder) throws
    {
        let container           = try decoder.container(keyedBy: CodingKeys.self)
        let snippetContainer    = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .snippet)
        
        //Parse title
        self.title              = try snippetContainer.decode(String.self, forKey: .title)
        
        // Parse Description
        self.description        = try snippetContainer.decode(String.self, forKey: .description)
        
        // Parse Published
        self.published          = try snippetContainer.decode(Date.self, forKey: .published)
        
        // Parse Thumbnails
        let thumbnailContainer  = try snippetContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .thumbnails)
        let highContainer       = try thumbnailContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .high)
        self.thumbnail          = try highContainer.decode(String.self, forKey: .thumbnail)
        
        // Parse Video Id
        let resourceIdContainer = try snippetContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .resourceId)
        self.videoId            = try resourceIdContainer.decode(String.self, forKey: .videoId)
    }
}
