//
//  TwitterUser.swift
//  TwitterAPIApp
//
//  Created by David Zack Walker on 06.07.20.
//  Copyright © 2020 dsfw. All rights reserved.
//

import Foundation

public class TwitterUser {
    public var username : String
    public var screenName : String
    public var description : String
    public var profileImageUrl : URL?
    
    public init() {
        username = ""
        screenName = ""
        description = ""
    }
}
