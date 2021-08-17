//
//  Constants.swift
//  YouTubeOndayBuild
//
//  Created by Sumit Makkar on 17/08/21.
//

import Foundation


struct Constants
{
    static let API_KEY     = "AIzaSyCObYwZBX5fllaJEaQGrPk7SAQBod5Okes"
    static let PLAYLIST_ID = "PLlrATfBNZ98dudnM48yfGUldqGD0S4FFb"
    static let API_URL     = "https://youtube.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=\(Constants.PLAYLIST_ID)&key=\(Constants.API_KEY)"
}
