//
//  Tweet.swift
//  TwitterAPIApp
//
//  Created by David Zack Walker on 01.07.20.
//  Copyright © 2020 dsfw. All rights reserved.
//

import Foundation

public class Tweet : Codable {
    public var content : String
    public var user : TwitterUser?
    public var locationString : String
    public var retweetCount : Int
    public var likeCount : Int
    
    public init() {
        content = ""
        locationString = ""
        retweetCount = 0
        likeCount = 0
    }
    
    // For encoding/decoding to string for user defaults
    func encode() -> String {
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(self)
            return String(data: jsonData, encoding: String.Encoding.utf8)!
        }
        catch {
            return ""
        }
    }
    
    static func decode(from: Data) -> Tweet? {
        let jsonDecoder = JSONDecoder()
        do {
            return try jsonDecoder.decode(Tweet.self, from: from)
        }
        catch {
            return nil
        }
    }
}
