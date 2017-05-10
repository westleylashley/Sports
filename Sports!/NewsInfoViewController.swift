//
//  NewsInfoViewController.swift
//  sports
//
//  Created by Westley Lashley on 3/21/17.
//  Copyright © 2017 Westley Lashley. All rights reserved.
//

import Foundation
import UIKit

class NewsInfoViewController: UIViewController {
    
    @IBOutlet weak var dataScrollView: UIScrollView!
    @IBOutlet weak var dataImageView: UIImageView!
    @IBOutlet weak var dataDescriptionText: UITextView!
    @IBOutlet weak var dataTitleLabel: UILabel!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    
    var sports: SportsAPI!

// Close button
    @IBAction func closeButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    // Full Story link button
    @IBAction func fullStoryButton(_ sender: Any) {
        let alertController =  UIAlertController (title: "", message: "You will be redirected to the website.", preferredStyle: UIAlertControllerStyle.alert)
        
        let okButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
                if let url = URL(string: self.sports.url!) {
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
            }
        })
        
        let cancelButton = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
            
            alertController.addAction(okButton)
            alertController.addAction(cancelButton)

        self.present(alertController, animated: true, completion: nil)
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataScrollView.layer.cornerRadius = 7.0

            dataImageView.image = sports.imageDownload
            dataTitleLabel.text = sports.title
            dataDescriptionText.text = sports.description
            //sourceTextField.text = "Source: \(sports.source)"
            //fullStoryButton(sender: Any) = sports.fullStory
    }

}
