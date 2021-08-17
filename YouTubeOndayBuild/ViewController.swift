//
//  ViewController.swift
//  YouTubeOndayBuild
//
//  Created by Sumit Makkar on 01/06/21.
//

import UIKit

class ViewController: UIViewController
{
    // MARK: - Properties
    var model = Model()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad()
    {
        super.viewDidLoad()
        model.getVideos()
    }
}
