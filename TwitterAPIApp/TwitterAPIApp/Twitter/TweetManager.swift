//
//  TweetManager.swift
//  TwitterAPIApp
//
//  Created by David Zack Walker on 16.07.20.
//  Copyright © 2020 dsfw. All rights reserved.
//

import Foundation

public class TweetManager {
    public static let shared = TweetManager()
    private var encodedFavorites : [String]
    private let favoritesDefaultsKey = "favoriteTweets"
    private let defaults = UserDefaults.standard
    
    private init() {
        encodedFavorites = []
    }
    
    public func addFavorite(tweet : Tweet) {
        let encodedTweet = tweet.encode()
        encodedFavorites.append(encodedTweet)
        saveFavorites()
    }
    
    public func getFavorites() -> [Tweet] {
        guard let loadedFavs = defaults.array(forKey: favoritesDefaultsKey) else {
            return []
        }
        
        encodedFavorites = loadedFavs as! [String]
        var favorites = [Tweet]()
        for fav in encodedFavorites {
            let data = fav.data(using: .utf8)!
            let tweet = Tweet.decode(from: data)
            favorites.append(tweet!)
        }
        
        return favorites
    }
    
    public func clearFavorites() {
        encodedFavorites = []
        saveFavorites()
    }
    
    private func saveFavorites() {
        defaults.set(encodedFavorites, forKey: favoritesDefaultsKey)
    }
}
