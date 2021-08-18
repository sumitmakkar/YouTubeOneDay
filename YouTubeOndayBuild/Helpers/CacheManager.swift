//
//  CacheManager.swift
//  YouTubeOndayBuild
//
//  Created by Sumit Makkar on 18/08/21.
//

import Foundation

class CacheManager
{
    static var cache = [String: Data]()
    
    static func setVideoCache(_ url: String, _ data: Data)
    {
        cache[url] = data
    }
    
    static func getVideoCache(_ url: String?) -> Data?
    {
        guard let urlUnwrapped = url else { return nil }
        return cache[urlUnwrapped]
    }
}
