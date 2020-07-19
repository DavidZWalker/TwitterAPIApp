//
//  TweetsTableViewController.swift
//  TwitterAPIApp
//
//  Created by Fabian Schneider on 30.06.20.
//  Copyright © 2020 dsfw. All rights reserved.
//

import UIKit
class TweetTableViewCell: UITableViewCell{
    
    @IBOutlet weak var tweetProfilePicture: UIImageView!
    @IBOutlet weak var tweetNickname: UILabel!
    @IBOutlet weak var tweetUsername: UILabel!
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var tweetRetweetCount: UILabel!
    @IBOutlet weak var tweetLikeCount: UILabel!
    @IBOutlet weak var tweetLocation: UILabel!
}

class TweetsTableViewController: UITableViewController {
    
    @IBOutlet weak var navigatonBar: UINavigationItem!
    var tweets = [Tweet]()
    let loadingIndicator = LoadingIndicatorViewController()
    let tweetManager = TweetManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        configureRefreshControl()
        
        showLoadingScreeen(show: true)
        TwitterAPI.shared.findTweetsForCurrentLocation(completionHandler: refreshTableview)
    }
    
    func refreshTableview(tweets: [Tweet]){
        
        //refresh Location here
        
        
        self.tweets = tweets
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.showLoadingScreeen(show: false)
        }
    }
    
    func configureRefreshControl () {
        // Adding the refresh control to tableview
        self.tableView.refreshControl = UIRefreshControl()
        self.tableView.refreshControl?.addTarget(self, action:
            #selector(handleRefreshControl), for: .valueChanged)
    }
    
    @objc func handleRefreshControl() {
        //reloading content
        TwitterAPI.shared.findTweetsForCurrentLocation(completionHandler: refreshTableview)
        
        // Dismiss the refresh control.
        DispatchQueue.main.async {
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetTableViewCell
        
        cell.tweetNickname.text = tweets[indexPath.row].user?.username
        cell.tweetUsername.text =
            tweets[indexPath.row].user?.screenName
        cell.tweetText.text = tweets[indexPath.row].content
        cell.tweetRetweetCount.text = String(tweets[indexPath.row].retweetCount)
        cell.tweetLikeCount.text = String(tweets[indexPath.row].likeCount)
        cell.tweetLocation.text = tweets[indexPath.row].locationString
        
        cell.tweetProfilePicture.load(url: (tweets[indexPath.row].user?.profileImageUrl)!)
        
        
        return cell
    }
    
    func showLoadingScreeen(show: Bool){
        
        if(show){
            //add the Indicator to the View
            addChild(loadingIndicator)
            loadingIndicator.view.frame = view.frame
            view.addSubview(loadingIndicator.view)
            loadingIndicator.didMove(toParent: self)
        }
        else{
            loadingIndicator.willMove(toParent: nil)
            loadingIndicator.view.removeFromSuperview()
            loadingIndicator.removeFromParent()
        }
    }
}
