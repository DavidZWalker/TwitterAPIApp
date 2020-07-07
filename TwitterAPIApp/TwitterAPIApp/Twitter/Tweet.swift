//
//  Tweet.swift
//  TwitterAPIApp
//
//  Created by David Zack Walker on 01.07.20.
//  Copyright © 2020 dsfw. All rights reserved.
//

import Foundation

public class Tweet {
    public var content : String
    public var user : TwitterUser?
    public var locationString : String
    public var retweetCount : Int
    public var likeCount : Int
    public var date : Date?
    
    public init() {
        content = ""
        locationString = ""
        retweetCount = 0
        likeCount = 0
    }
}
