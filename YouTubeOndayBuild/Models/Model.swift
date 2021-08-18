//
//  Model.swift
//  YouTubeOndayBuild
//
//  Created by Sumit Makkar on 17/08/21.
//

import Foundation

protocol ModelDelegate
{
    func videosFetched(_ videos: [Video])
}

class Model
{
    var delegate: ModelDelegate?
    
    func getVideos()
    {
        //1. Create URL Object
        guard let url = URL(string: Constants.API_URL) else { return }
        
        //2. Get a URLSession Object
        let session = URLSession.shared
        
        //3. Get a Data Task from the URLSession Object
        let dataTask = session.dataTask(with: url) { [weak self] (data, response, error) in
            guard let weakSelf = self else { return }
            if error != nil || data == nil
            {
                debugPrint("API ERROR: \(error?.localizedDescription)")
                return
            }
            
            //4. Parse data into Video object
            do
            {
                let decoder                  = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let response                 = try decoder.decode(Response.self, from: data!)
                dump(response)
                
                guard let videos = response.items else { return }
                weakSelf.delegate?.videosFetched(videos)
            }
            catch
            {
                debugPrint("PARSING ERROR: for Youtube API")
            }
            
        }
        
        //5. Kick off the task
        dataTask.resume()
    }
}
