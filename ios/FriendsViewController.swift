//
//  FirstViewController.swift
//  ios
//
//  Created by 장상현 on 2017. 11. 3..
//  Copyright © 2017년 jex. All rights reserved.
//

import UIKit

extension String {
    var firstUppercased: String {
        guard let first = first else { return "" }
        return String(first).uppercased() + dropFirst()
    }
}

class FriendsViewController: UITableViewController {
    var friendList = [FriendVO]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.callFriendsAPI()
        self.refreshControl?.addTarget(self, action: #selector(FriendsViewController.handleRefresh(_:)), for: UIControlEvents.valueChanged)
    }
    
    func handleRefresh(_ refreshControl: UIRefreshControl) {
        // Do some reloading of data and update the table view's data source
        // Fetch more objects from a web service, for example...
        
        // Simply adding an object to the data source for this example
        self.callFriendsAPI()
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func callFriendsAPI() {
        let url = "https://randomuser.me/api/?results=20&inc=name,picture,nat,cell,email,id"
        let apiURI : URL! = URL(string: url)
        let apidata = try! Data(contentsOf: apiURI)
        
        let log = NSString(data: apidata, encoding: String.Encoding.utf8.rawValue) ?? "데이터가 없습니다"
        NSLog("API Result=\(log)")
    
        self.friendList = [FriendVO]()
        do {
            let apiDictionary = try JSONSerialization.jsonObject(with: apidata, options: []) as! NSDictionary
            let results = apiDictionary["results"] as? NSArray
            
            for obj in results! {
                
                let r = obj as! NSDictionary
                let fvo = FriendVO()
                
                let name = r["name"] as! NSDictionary
                let title = (name["title"] as! String).firstUppercased
                let first = (name["first"] as! String).firstUppercased
                let last = (name["last"] as! String).firstUppercased
                
                fvo.name = "\(String(describing: title)). \(String(describing: first)) \(String(describing: last))"
                let pictures = r["picture"] as! NSDictionary
                fvo.picture = pictures["thumbnail"] as? String
                fvo.email = r["email"] as? String
                fvo.cell = r["cell"] as? String
                fvo.nat = (r["nat"] as? String)?.uppercased()
                fvo.last = "\(String(describing: title)). \(String(describing: last))"
                
                self.friendList.append(fvo)
            }
        } catch {
            let alert = UIAlertController(title: "실패",
                                          message: "데이터 분석이 실패했습니다.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .cancel))
            self.present(alert, animated: false)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.friendList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = self.friendList[indexPath.row]
        
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
            let friendInfo = self.friendList[path!.row]
            
            let detailVC = segue.destination as? DetailViewController
            detailVC?.fvo = friendInfo
        }
    }
}
