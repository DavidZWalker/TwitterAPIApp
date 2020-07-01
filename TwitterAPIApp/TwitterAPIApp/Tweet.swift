//
//  Tweet.swift
//  TwitterAPIApp
//
//  Created by David Zack Walker on 01.07.20.
//  Copyright © 2020 dsfw. All rights reserved.
//

import Foundation

class Tweet {
    var content : String
    var author : String
    var replies : [Tweet]
    var location : Location?
    var retweetCount : Int
    var likeCount : Int
    
    init() {
        content = ""
        author = ""
        replies = []
        retweetCount = 0
        likeCount = 0
    }
}
