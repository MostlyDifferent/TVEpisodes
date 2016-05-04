//
//  APIManager.swift
//  TVEpisodes
//
//  Created by Alexander Sramek on 5/2/16.
//  Copyright © 2016 MostlyDiff. All rights reserved.
//

import Foundation

class APIManager
{
    func fLoadData(urlString: String, completion: [TVEpisode] -> Void)
    {
        
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        let session = NSURLSession(configuration: config)
        let url = NSURL(string: urlString)!
        
            //Create a task and give it the following
        let task = session.dataTaskWithURL(url)
        {(data, response, error) -> Void in     //This is a function with 3 parameters and a void return
            
                //After the data fetch is complete, this block of code is called.
            
                //Did we get the data?
            if error != nil
            {
                print(error!.localizedDescription)
            }
            else
            {
                do
                {
                        //Make a json object out of the data we got, and drill down a bit. Hope it works (if not, catch)
                    if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? JSONDictionary,
                        feed = json["feed"] as? JSONDictionary,
                        entries = feed["entry"] as? JSONArray
                    {
                            //Make TVEpisode objects out of the entries
                        var episodes = [TVEpisode]()
                        for entry in entries
                        {
                            let episode = TVEpisode(data: entry as! JSONDictionary)
                            episodes.append(episode)
                        }//entry in entries
                        
                            //The data is parsed, and ready to go out to the interface.
                            //Dispatch it so that it may go along its merry way in its own time.
                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0))
                        {
                            dispatch_async(dispatch_get_main_queue())
                            {
                                completion(episodes)
                            }//dispatch main queue
                        }//dispatch global queue
                        
                    }//if json
                    
                }//do
                catch
                {
                    print("Error in JSON Serialization")
                }//catch
                
            }//if no error
            
        }//session.dataTaskWithURL
        
        task.resume()
        
    }//fLoadData
    
}//APIManager