//
//  JsonDataParser.swift
//  TwitterAPIApp
//
//  Created by David Zack Walker on 01.07.20.
//  Copyright © 2020 dsfw. All rights reserved.
//

import Foundation

public class JsonDataParser {
    
    static let shared = JsonDataParser()
    
    private init() {}
    
    public func getJsonDictionary(fromData: Data) -> [String : Any] {
        do {
            guard let dict = try JSONSerialization.jsonObject(with: fromData, options: []) as? [String: Any] else {
                print("Given data cannot be cast to type [String:Any]. Returning empty dictionary...")
                return [:]
            }
            
            return dict
            
        }
        catch {
            print("An exception was caught while parsing the JSON data. Returning empty dictionary...")
            return [:]
        }
    }
}
