//
//  VideoTableViewCell.swift
//  YouTubeOndayBuild
//
//  Created by Sumit Makkar on 18/08/21.
//

import UIKit

class VideoTableViewCell: UITableViewCell
{
    // MARK: - IBOutlets
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    // MARK: - Properties
    var video: Video?
    
    // MARK: - Lifecycle Methods
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // MARK: - UI Methods
    func setupCell(_ video: Video)
    {
        self.video            = video
        self.titleLabel.text  = self.video?.title
        self.dateLabel.text   = getVideoDate()
        if let thumbnailImageData = CacheManager.getVideoCache(self.video?.thumbnail)
        {
            thumbnailImageView?.image = UIImage(data: thumbnailImageData)
        }
        else
        {
            updateThumbnailImage()
        }
    }
    
    private func getVideoDate() -> String?
    {
        guard let videoDate = self.video?.published else { return nil }
        let dateFormatter        = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        return dateFormatter.string(from: videoDate)
    }
    
    private func updateThumbnailImage()
    {
        guard let thumbnailURLString = self.video?.thumbnail, let thumbnailURL = URL(string: thumbnailURLString) else { return }
        
        //Get a URLSession Object
        let session = URLSession.shared
        
        //Get a Data Task from the URLSession Object
        let dataTask = session.dataTask(with: thumbnailURL) { [weak self] (data, response, error) in
            if error == nil && data != nil
            {
                guard let weakSelf = self, thumbnailURL.absoluteString == weakSelf.video?.thumbnail, let imageData = data else { return }
                // create the image object
                let image = UIImage(data: imageData)
                CacheManager.setVideoCache(thumbnailURL.absoluteString, imageData)
                DispatchQueue.main.async {
                    weakSelf.thumbnailImageView?.image = image
                }
            }
        }
        
        //Kisk off the task
        dataTask.resume()
    }
}
