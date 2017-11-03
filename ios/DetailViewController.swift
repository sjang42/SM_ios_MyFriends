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
    
    @IBAction func addButton(_ sender: UIButton) {
        
    }
    
    override func viewDidLoad() {
        NSLog("linkurl = \(String(describing: self.fvo?.name)), title=\(String(describing: self.fvo?.last))")
        
        let url: URL! = URL(string: fvo.picture!)
        let imageData = try! Data(contentsOf: url)
        pictureImage.image = UIImage(data: imageData)
        nameLabel.text = fvo?.name
        emailLabel.text = fvo?.email
        cellLabel.text = fvo?.cell
        nationLabel.text = fvo?.nat
        titleTitle.title = fvo?.last
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
