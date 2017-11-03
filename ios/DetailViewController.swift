//
//  DetailViewController.swift
//  ios
//
//  Created by 장상현 on 2017. 11. 3..
//  Copyright © 2017년 jex. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var titleTitle: UINavigationItem!
    @IBOutlet var pictureImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var cellLabel: UILabel!
    @IBOutlet var nationLabel: UILabel!
    
    // if this friend is not in Best, idxBest is -1
    var idxBest: Int!
    var bestFriends: [FriendVO] = []
    var fvo : FriendVO!
    var ud = UserDefaults.standard
    
    @IBOutlet var btnAdd: UIButton!
    @IBAction func addButton(_ sender: UIButton) {
        if (idxBest) == -1 {
            bestFriends.append(fvo)
            idxBest = bestFriends.count - 1
            btnAdd.setTitle("-", for: .normal)
        }
        else {
            bestFriends.remove(at: idxBest)
            idxBest = -1
            btnAdd.setTitle("+", for: .normal)
        }

        let data = NSKeyedArchiver.archivedData(withRootObject: bestFriends)
        ud.set(data, forKey: "bestFriends")
    }
    
    override func viewDidLoad() {
        NSLog("linkurl = \(String(describing: self.fvo?.name)), title=\(String(describing: self.fvo?.last))")
        self.idxBest = -1
        let url: URL! = URL(string: fvo.picture!)
        let imageData = try! Data(contentsOf: url)
        pictureImage.image = UIImage(data: imageData)
        nameLabel.text = fvo?.name
        emailLabel.text = fvo?.email
        cellLabel.text = fvo?.cell
        nationLabel.text = fvo?.nat
        titleTitle.title = fvo?.last
        if let data = ud.object(forKey: "bestFriends") as? Data {
            bestFriends = NSKeyedUnarchiver.unarchiveObject(with: data) as! [FriendVO]
        }
        
        let i = bestFriends.index(where: { $0.email == emailLabel.text })
        
        if i == nil {
            btnAdd.setTitle("+", for: .normal)
        } else {
            btnAdd.setTitle("-", for: .normal)
            idxBest = i!
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue_web" {
            
            let detailVC = segue.source as? DetailViewController
            let nation = detailVC?.nationLabel.text
            
            let webVC = segue.destination as? WebViewController
            webVC?.nation = nation
        }
    }
}
