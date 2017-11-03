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
    
    var fvo : FriendVO!
    
    @IBAction func onAddBestfriend(_ sender: UIBarButtonItem) {
        NSLog("ldf")
    }
    
    override func viewDidLoad() {
        NSLog("linkurl = \(String(describing: self.fvo?.name)), title=\(String(describing: self.fvo?.last))")
        
        titleTitle.title = fvo?.last
        
        let url: URL! = URL(string: fvo.picture!)
        let imageData = try! Data(contentsOf: url)
        pictureImage.image = UIImage(data: imageData)
        nameLabel.text = fvo?.name
        emailLabel.text = fvo?.email
        cellLabel.text = fvo?.cell
        nationLabel.text = fvo?.nat
    }
    
}
//
//cell.name?.text = row.name
//cell.email?.text = row.email
//let url: URL! = URL(string: row.picture!)
//let imageData = try! Data(contentsOf: url)
//cell.photo?.image = UIImage(data: imageData)
//
