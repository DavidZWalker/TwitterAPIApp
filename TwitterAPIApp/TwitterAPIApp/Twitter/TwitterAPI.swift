//
//  TwitterAPI.swift
//  TwitterAPIApp
//
//  Created by David Zack Walker on 01.07.20.
//  Copyright © 2020 dsfw. All rights reserved.
//

import Foundation

public class TwitterAPI {
    public static let shared = TwitterAPI()
    private let searchBaseUrl = "https://api.twitter.com/1.1/search/tweets.json"
    private let authService = TwitterAuthorizationService.shared
    private var locationService = LocationService.shared
    private let jsonParser = JsonDataParser.shared
    private var bearerToken : String = ""
    private var authorizationStatus : AuthorizationStatus = .NotAuthorized
    private var searchRequestCompletionCallback : ([Tweet]) -> Void = { _ in }
    public var searchRadius = 100
    public var resultType = "recent"
    public var maxTweetCount = 10
    public var foundTweets = [Tweet]()
    
    private let paramName_query = "q"
    private let paramName_location = "geocode"
    private let paramName_resultType = "result_type"
    private let paramName_maxTweetCount = "count"
    
    private init() {
        locationService.setUpdateMode(mode: .OneTime)
    }
    
    public func findTweetsForCurrentLocation(completionHandler: @escaping ([Tweet]) -> Void) {
        self.searchRequestCompletionCallback = completionHandler
        if authorizationStatus != .Authorized {
            authorize()
        }
        else {
            updateLocation()
        }
    }
    
    private func authorize() {
        authorizationStatus = .Authorizing
        authService.generalAuthCallback = authorizationCallback
        authService.authorize()
    }
    
    private func authorizationCallback(bearerToken: String) {
        print("App authorized. Access to Twitter API granted.")
        self.authorizationStatus = .Authorized
        self.bearerToken = bearerToken
        
        // once authorized, location service can be used for the api call
        updateLocation()
    }
    
    private func updateLocation() {
        locationService.locationUpdateCallback = loadTweets
        locationService.updateLocation()
    }
    
    private func loadTweets(forLocation : Location) {
        let locationString = String(forLocation.latitude)
            + ","
            + String(forLocation.longitude)
            + ","
            + String(searchRadius) + "km"
        let searchCall = createSearchApiCall(forLocationString: locationString)
        searchCall.execute()
    }
    
    private func createSearchApiCall(forLocationString: String) -> APICall {
        return APICallBuilder()
            .baseUrl(url: searchBaseUrl)
            .addQueryParameter(paramName: paramName_query, paramValue: "")
            .addQueryParameter(paramName: paramName_location, paramValue: forLocationString)
            .addQueryParameter(paramName: paramName_resultType, paramValue: resultType)
            .addQueryParameter(paramName: paramName_maxTweetCount, paramValue: String(maxTweetCount))
            .addHeaderFieldValue(headerField: "Authorization", value: "Bearer " + self.bearerToken)
            .onDataReceived(dataHandler: onTwitterApiDataReceived)
            .onError(errorHandler: {
                error in
                print("Error lol")
            })
            .build()
    }
    
    private func onTwitterApiDataReceived(data : Data?) -> Void {
        let json = jsonParser.getJsonDictionary(fromData: data!)
        
        print("FULL JSON:")
        print(json)
            
        let tweets = getTweetsFromJson(jsonObj: json["statuses"] as! [[String:Any]])
        
        searchRequestCompletionCallback(tweets)
    }
    
    private func getTweetsFromJson(jsonObj: [[String:Any]]) -> [Tweet] {
        print("JSON OBJECT:")
        print(jsonObj)
        var tweets = [Tweet]()
        
        // Create the tweet object from the JSON data
        for status in jsonObj {
            let tweet = Tweet()
            let user = TwitterUser()
            tweet.retweetCount = status["retweet_count"] as! Int
            tweet.likeCount = status["favorite_count"] as! Int
            tweet.content = status["text"] as! String
            user.username = (status["user"] as! [String:Any])["name"] as! String
            user.screenName = (status["user"] as! [String:Any])["screen_name"] as! String
            user.description = (status["user"] as! [String:Any])["description"] as! String
            user.profileImageUrl = URL(string: (status["user"] as! [String:Any])["profile_image_url_https"] as! String)
            tweet.locationString = (status["user"] as! [String:Any])["location"] as! String
            tweet.user = user
            tweets.append(tweet)
        }
        
        return tweets
    }
}
