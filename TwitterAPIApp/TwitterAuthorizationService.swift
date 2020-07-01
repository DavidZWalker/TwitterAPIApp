//
//  TwitterAuthorizationService.swift
//  TwitterAPIApp
//
//  Created by David Zack Walker on 01.07.20.
//  Copyright © 2020 dsfw. All rights reserved.
//

import Foundation

class TwitterAuthorizationService {
    static let shared = TwitterAuthorizationService()
    private let consumerKey = "0vjJTcyFFTOkbTxy3l7c7rVjj"
    private let consumerSecret = "uCHT6cNsK9VTWqBCX6Wrekse0wcLNBLP1kd6gGG3QkEZCMxwpI"
    private let authUrl = "https://api.twitter.com/oauth2/token"
    var authorizationCallback : (String) -> Void = { _ in }
    
    private init() {
    }
    
    func authorize() {
        let authHeaderValue = "Basic " + getBase64EncodedString()
        let contentTypeHeaderValue = "application/x-www-form-urlencoded;charset=UTF-8"
        let grant_type = "grant_type=client_credentials"
        
        APICallBuilder()
            .baseUrl(url: authUrl)
            .setRequestMethod(requestMethod: .POST)
            .addHeaderFieldValue(headerField: "Authorization", value: authHeaderValue)
            .addHeaderFieldValue(headerField: "Content-Type", value: contentTypeHeaderValue)
            .httpBody(body: grant_type)
            .onDataReceived(dataHandler: onAuthorizationDataReceived)
            .build()
            .execute()
    }
    
    private func getBase64EncodedString() -> String {
        let consumerKeyRFC1738 = consumerKey.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let consumerSecretRFC1738 = consumerSecret.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let combinedKey = consumerKeyRFC1738! + ":" + consumerSecretRFC1738!
        let combinedKeyData = combinedKey.data(using: String.Encoding.ascii, allowLossyConversion: true)
        let base64EncodedKeyAndSecret = combinedKeyData?.base64EncodedString(options: Data.Base64EncodingOptions())
        
        return base64EncodedKeyAndSecret!
    }
    
    private func onAuthorizationDataReceived(data: Data?) {
        let json = JsonDataParser.shared.getJsonDictionary(fromData: data!)
            
        if let token = json["access_token"] as? String {
            self.authorizationCallback(token)
        }
            
        print(json)
    }
}
