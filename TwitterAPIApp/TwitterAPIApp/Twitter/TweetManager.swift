//
//  TweetManager.swift
//  TwitterAPIApp
//
//  Created by David Zack Walker on 16.07.20.
//  Copyright © 2020 dsfw. All rights reserved.
//

import Foundation

public class TweetManager {
    static let shared = TweetManager()
    private var favorites : [Tweet]
    private let favoritesDefaultsKey = "favoriteTweets"
    
    private init() {
        favorites = []
    }
    
    public func addFavorite(tweet : Tweet) {
        saveFavorites()
    }
    
    public func getFavorites() -> [Tweet] {
        return favorites
    }
    
    public func clearFavorites() {
        saveFavorites()
    }
    
    private func saveFavorites() {
        
    }
}
