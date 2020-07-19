//
//  FavoritesTableViewController.swift
//  TwitterAPIApp
//
//  Created by Fabian Schneider on 19.07.20.
//  Copyright © 2020 dsfw. All rights reserved.
//

import UIKit

class FavoritesTableViewController: UITableViewController {
    
    var favorites = [Tweet]()
    let loadingIndicator = LoadingIndicatorViewController()
    let tweetManager = TweetManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        showLoadingScreeen(show: true)
        loadFavorites()
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    func loadFavorites() {
        favorites = tweetManager.getFavorites()
        tableView.reloadData()
        showLoadingScreeen(show: false)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete){
            tweetManager.removeFavorite(tweet: favorites[indexPath.row])
            favorites = tweetManager.getFavorites()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
    }
    override func viewDidAppear(_ animated: Bool) {
        loadFavorites()
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return favorites.count
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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetTableViewCell
        
        cell.tweetNickname.text = favorites[indexPath.row].user?.username
        cell.tweetUsername.text =
            favorites[indexPath.row].user?.screenName
        cell.tweetText.text = favorites[indexPath.row].content
        cell.tweetRetweetCount.text = String(favorites[indexPath.row].retweetCount)
        cell.tweetLikeCount.text = String(favorites[indexPath.row].likeCount)
        cell.tweetLocation.text = favorites[indexPath.row].locationString
        
        cell.tweetProfilePicture.load(url: (favorites[indexPath.row].user?.profileImageUrl)!)
        
        
        return cell
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
