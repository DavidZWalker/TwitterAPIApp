//
//  Extensions.swift
//  TwitterAPIApp
//
//  Created by Fabian Schneider on 09.07.20.
//  Copyright © 2020 dsfw. All rights reserved.
//

import UIKit

class Extensions: NSObject {

}

extension UIImageView{
    func load(url:URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url){
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
