//
//  TableViewCell.swift
//  sports
//
//  Created by Westley Lashley on 3/20/17.
//  Copyright © 2017 Westley Lashley. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var articleImageView: UIImageView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func awakeFromNib() {
        super.awakeFromNib()
    
    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5), execute: {
    self.activityIndicator.stopAnimating()
    })
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
