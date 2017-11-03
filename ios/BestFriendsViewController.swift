//
//  SecondViewController.swift
//  ios
//
//  Created by 장상현 on 2017. 11. 3..
//  Copyright © 2017년 jex. All rights reserved.
//

import UIKit

class BestFriendsViewController: UITableViewController {

    var bestFriends: [FriendVO] = []
    var ud = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.callFriendsLocal()
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.callFriendsLocal()
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let row = indexPath.row
        
        bestFriends.remove(at: row)
        let data = NSKeyedArchiver.archivedData(withRootObject: bestFriends)
        ud.set(data, forKey: "bestFriends")
        self.callFriendsLocal()
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {

        let row = sourceIndexPath.row
        let friendToMove = bestFriends[row]
        bestFriends.remove(at: row)
        bestFriends.insert(friendToMove, at: destinationIndexPath.row)
        let data = NSKeyedArchiver.archivedData(withRootObject: bestFriends)
        ud.set(data, forKey: "bestFriends")
    }
    
    func callFriendsLocal() {
        if let data = ud.object(forKey: "bestFriends") as? Data {
            self.bestFriends = NSKeyedUnarchiver.unarchiveObject(with: data) as! [FriendVO]
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bestFriends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = self.bestFriends[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as! FriendCell
        
        cell.name?.text = row.name
        cell.email?.text = row.email
        let url: URL! = URL(string: row.picture!)
        let imageData = try! Data(contentsOf: url)
        cell.photo?.image = UIImage(data: imageData)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue_detail" {
            let cell = sender as! FriendCell
            let path = self.tableView.indexPath(for: cell)
            let friendInfo = self.bestFriends[path!.row]
            
            let detailVC = segue.destination as? DetailViewController
            detailVC?.fvo = friendInfo
        }
    }
    
    
}

