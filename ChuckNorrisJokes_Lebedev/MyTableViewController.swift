//
//  myTableViewController.swift
//  ChuckNorrisJokes_Lebedev
//
//  Created by Владимир on 15/06/2019.
//  Copyright © 2019 Владимир. All rights reserved.
//

import UIKit
import Alamofire

class myTableViewController: UITableView, UITableViewDataSource, UITableViewDelegate {

    var jokesArray = [AnyObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
}
