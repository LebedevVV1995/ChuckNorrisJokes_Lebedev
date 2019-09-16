//
//  MyTableViewCell.swift
//  ChuckNorrisJokes_Lebedev
//
//  Created by Владимир on 15/06/2019.
//  Copyright © 2019 Владимир. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var jokesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
