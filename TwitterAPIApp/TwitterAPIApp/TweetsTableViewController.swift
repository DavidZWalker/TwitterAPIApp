//
//  TweetsTableViewController.swift
//  TwitterAPIApp
//
//  Created by Fabian Schneider on 30.06.20.
//  Copyright © 2020 dsfw. All rights reserved.
//

import UIKit

class TweetsTableViewController: UITableViewController {
    
    //var tweets = [Tweet]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TwitterAPI.shared.findTweetsForCurrentLocation(completionHandler: { _ in })
        
        // Do any additional setup after loading the view.
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    /*override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return tweets.count
     }
     
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath)
        
        cell.textLabel?.text = items[indexPath.row].Tweet
        
        return cell
    }
 */
    
}
