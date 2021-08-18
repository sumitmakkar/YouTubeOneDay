//
//  ViewController.swift
//  YouTubeOndayBuild
//
//  Created by Sumit Makkar on 01/06/21.
//

import UIKit

class ViewController: UIViewController
{
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var model  = Model()
    var videos = [Video]()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.dataSource      = self
        tableView.delegate        = self
        model.delegate            = self
        model.getVideos()
        tableView.tableFooterView = UIView()
    }
}

// MARK: - Table View Data Source
extension ViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.VIDEOCELL_ID, for: indexPath) as? VideoTableViewCell else { return UITableViewCell() }
        cell.setupCell(videos[indexPath.row])
        return cell
    }
}

// MARK: - Table View Delegate
extension ViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
    }
}

// MARK: - Model Delegate
extension ViewController: ModelDelegate
{
    func videosFetched(_ videos: [Video])
    {
        // Set the returned videos
        self.videos = videos
        
        // Reload data on table view
        DispatchQueue.main.async { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.tableView.reloadData()
        }
    }
}
