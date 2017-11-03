//
//  WebViewController.swift
//  ios
//
//  Created by 장상현 on 2017. 11. 4..
//  Copyright © 2017년 jex. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet var wv: UIWebView!
    @IBOutlet var myActivityIndicator: UIActivityIndicatorView!
    
    var nation: String!
    
    override func viewDidLoad() {
        NSLog("nation = \(String(describing: self.nation!))")
        
        let url = URL(string: ("https://www.google.com/search?q=\(self.nation!)"))
        let req = URLRequest(url: url!)
        
        self.wv.loadRequest(req)
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        self.myActivityIndicator.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.myActivityIndicator.stopAnimating()
    }
    
    @IBAction func btnGoBack(_ sender: UIBarButtonItem) {
        wv.goBack()
    }
    
    @IBAction func btnStop(_ sender: UIBarButtonItem) {
        wv.stopLoading()
    }
    
    @IBAction func btnRefresh(_ sender: UIBarButtonItem) {
        wv.reload()
    }
    
    @IBAction func btnGoForward(_ sender: UIBarButtonItem) {
        wv.goForward()
    }
    
    @IBAction func btnClose(_ sender: UIBarButtonItem) {
         self.dismiss(animated: true, completion: nil)
    }
}
