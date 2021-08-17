//
//  Model.swift
//  YouTubeOndayBuild
//
//  Created by Sumit Makkar on 17/08/21.
//

import Foundation

class Model
{
    func getVideos()
    {
        //1. Create URL Object
        guard let url = URL(string: Constants.API_URL) else { return }
        
        //2. Get a URLSession Object
        let session = URLSession.shared
        
        //3. Get a Data Task from the URLSession Object
        let datatask = session.dataTask(with: url) { (data, response, error) in
            if error != nil || data == nil
            {
                debugPrint("API ERROR: \(error?.localizedDescription)")
                return
            }
        }
        
        //4. Kick off the task
        datatask.resume()
    }
}
