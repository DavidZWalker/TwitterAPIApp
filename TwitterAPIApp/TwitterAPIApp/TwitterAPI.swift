//
//  TwitterAPI.swift
//  TwitterAPIApp
//
//  Created by David Zack Walker on 01.07.20.
//  Copyright © 2020 dsfw. All rights reserved.
//

import Foundation

class TwitterAPI {
    static let shared = TwitterAPI()
    private let searchBaseUrl = "https://api.twitter.com/1.1/search/tweets.json"
    private let authService = TwitterAuthorizationService.shared
    private var locationService = LocationService.shared
    var isAuthorized = false
    private var bearerToken : String = ""
    var searchRadius = 10
    var resultType = "recent"
    var maxTweetCount = 50
    var foundTweets = [Tweet]()
    
    private let paramName_query = "q"
    private let paramName_location = "geocode"
    private let paramName_resultType = "result_type"
    private let paramName_maxTweetCount = "count"
    
    private init() {
        locationService.setUpdateMode(mode: .OneTime)
        authorize()
    }
    
    func findTweetsForCurrentLocation() {
        if isAuthorized {
            locationService.locationUpdateCallback = locationUpdateCallback
            locationService.updateLocation()
        }
        else {
            print ("App is not authorized. Please wait for access to be granted...")
        }
    }
    
    private func authorize() {
        authService.authorizationCallback = authorizationCallback
        authService.authorize()
    }
    
    private func authorizationCallback(bearerToken: String) {
        print("App authorized. Access to Twitter API granted.")
        isAuthorized = true
        self.bearerToken = bearerToken
    }
    
    private func locationUpdateCallback(location : Location) {
        let locationString = String(location.latitude)
            + ","
            + String(location.longitude)
            + ","
            + String(searchRadius)
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
            .onDataReceived(dataHandler: onTwitterApiDataReceived)
            .build()
    }
    
    private func onTwitterApiDataReceived(data : Data?) -> Void {
        do {
            guard let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] else {
                print("Error")
                return
            }
            
            print(json)
            
            if (json["statuses"] != nil) {
                print(json)
            }
        }
        catch {
            
        }
        
    }
}
