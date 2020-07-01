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
    private let authorizationBaseUrl = "https://api.twitter.com/oauth2/token"
    private var locationService : LocationService
    var searchRadius = 10
    var resultType = "recent"
    var maxTweetCount = 50
    var foundTweets = [Tweet]()
    
    private let paramName_query = "q"
    private let paramName_location = "geocode"
    private let paramName_resultType = "result_type"
    private let paramName_maxTweetCount = "count"
    
    private init() {
        locationService = LocationService.shared
        locationService.setUpdateMode(mode: .OneTime)
        locationService.locationUpdateCallback = locationUpdateCallback
        authorize()
    }
    
    func findTweetsForCurrentLocation() {
        locationService.updateLocation()
    }
    
    private func authorize() {
        APICallBuilder().baseUrl(url: authorizationBaseUrl).addQueryParameter(paramName: "grant_type", paramValue: "client_credentials").setRequestMethod(requestMethod: .POST).onDataReceived(
            dataHandler: {
                data in
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] else {
                        print("Error")
                        return
                    }
                    
                    print(json)
                }
                catch {
                    
                }
            }).build().execute()
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
