//
//  TVEpisode.swift
//  TVEpisodes
//
//  Created by Alexander Sramek on 5/2/16.
//  Copyright © 2016 MostlyDiff. All rights reserved.
//

import Foundation


func JSDicStr(data: JSONDictionary, first: String, second: String) -> String
{
    if let a = data[first] as? JSONDictionary,
        b = a[second] as? String
    {
        return b;
    }
    else
    {
        return ""
    }
}

func JS2DicStr(data: JSONDictionary, first: String, second: String, third: String) -> String
{
    if let a = data[first] as? JSONDictionary
    {
        return JSDicStr(a, first: second, second: third)
    }
    else
    {
        return ""
    }
}

class TVEpisode
{
    
    private var _vTitle: String
    private var _vImage: String
    private var _vSummary: String
    private var _vSeason: String
    private var _vPrice: String
    private var _vRights: String
    private var _vLink: String
    private var _vReleaseDate: String
    
    var vImageData: NSData?
    
    var vTitle: String{
        return _vTitle
    }
    
    var vImage: String{
        return _vImage
    }
    
    var vSummary: String{
        return _vSummary
    }
    
    var vSeason: String{
        return _vSeason
    }
    
    var vPrice: String{
        return _vPrice
    }
    
    var vRights: String{
        return _vRights
    }
    
    var vLink: String{
        return _vLink
    }
    
    var vReleaseDate: String{
        return _vReleaseDate
    }
    

    
    init(data: JSONDictionary)
    {
        
            //title
        
        if let title = data["title"] as? JSONDictionary,
                titleLabel = title["label"] as? String
        {
            _vTitle = titleLabel
        }
        else
        {
            _vTitle = ""
        }
        
            //image
        
        if let images = data["image"] as? JSONArray,
                image = images[0] as? JSONDictionary,
                imageLabel = image["label"] as? String
        {
            _vImage = imageLabel
        }
        else
        {
            _vImage = ""
        }
        
            //summary
        
        _vSummary = JSDicStr(data, first: "summary", second: "label")
        
            //season
        
        _vSeason = JS2DicStr(data, first: "im:collection", second: "im:name", third: "label")
        
            //price
        
        _vPrice = JSDicStr(data, first: "im:price", second: "label")
        
            //rights
        
        _vRights = JSDicStr(data, first: "rights", second: "label")
        
            //link
        
        if let links = data["link"] as? JSONArray,
                link0 = links[0] as? JSONDictionary
        {
            _vLink = JSDicStr(link0, first: "attributes", second: "href")
        }
        else
        {
            _vLink = ""
        }
        
            //release date
        
        _vReleaseDate = JSDicStr(data, first: "im:releasedate", second: "label")
        
        
        
    }//init
    
    
}//TVEpisode