//
//  ApiViewController.swift
//  ChuckNorrisJokes_Lebedev
//
//  Created by Владимир on 15/06/2019.
//  Copyright © 2019 Владимир. All rights reserved.
//

import UIKit

class ApiViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = NSURL(string: "http://www.icndb.com/api/"){
            let request = NSURLRequest(url: url as URL)
            webView.loadRequest(request as URLRequest)
        }
        webView.scalesPageToFit = true
    }
}
