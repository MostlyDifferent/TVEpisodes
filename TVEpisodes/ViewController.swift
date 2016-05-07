//
//  ViewController.swift
//  TVEpisodes
//
//  Created by Alexander Sramek on 5/2/16.
//  Copyright © 2016 MostlyDiff. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var vEpisodes = [TVEpisode]()
    
    
    @IBOutlet weak var uiDisplayLabel: UILabel!
    
    override func viewDidLoad()
    {
        
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(mReachabilityStatusChanged), name:"ReachStatusChanged", object: nil)
    
        mReachabilityStatusChanged()
        
        let api = APIManager()
        api.mLoadData("https://itunes.apple.com/us/rss/toptvepisodes/limit=10/genre=4008/json", completion: mDidLoadData)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func mDidLoadData(episodes: [TVEpisode])
    {
        vEpisodes = episodes
        
        for episode in episodes
        {
            print("Title = \(episode.vTitle)")
        }
    }
    
    
    func mReachabilityStatusChanged()
    {
        uiDisplayLabel.text = gReachabilityStatus
        
        switch(gReachabilityStatus)
        {
            case kStrReachStatusWifi:
                view.backgroundColor = UIColor.greenColor()
            case kStrReachStatusWWAN:
                view.backgroundColor = UIColor.yellowColor()
            case kStrReachStatusNone:
                view.backgroundColor = UIColor.redColor()
            default: return
            
        }
    }
    
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged", object: nil)
    }

}

