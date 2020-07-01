//
//  AuthorizationStatus.swift
//  TwitterAPIApp
//
//  Created by David Zack Walker on 01.07.20.
//  Copyright © 2020 dsfw. All rights reserved.
//

import Foundation

enum AuthorizationStatus {
    case NotAuthorized
    case Authorized
    case Authorizing
    case AuthorizationFailed
}
