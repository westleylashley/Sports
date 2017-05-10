//
//  ViewController.swift
//  sports
//
//  Created by Westley Lashley on 3/17/17.
//  Copyright © 2017 Westley Lashley. All rights reserved.
//

import UIKit
import Social

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var newsPicker: UIPickerView!
    @IBOutlet weak var tableView: UITableView!
    
    var selectIndexPath: IndexPath?
    var sports = [SportsAPI]()

// Strut with picker data
    struct PickerData {
        let apiName: String
        let displayName: String
    }

    var pickerData = [
        PickerData(apiName: "", displayName: "SELECT A SOURCE"),
        PickerData(apiName: "espn", displayName: "ESPN"),
        PickerData(apiName: "nfl-news", displayName: "NFL News"),
        PickerData(apiName: "fox-sports", displayName: "FOX Sports"),
        PickerData(apiName: "bbc-sport", displayName: "BBC Sports"),
        PickerData(apiName: "the-sport-bible", displayName: "The Sport Bible"),
        PickerData(apiName: "sky-sports-news", displayName: "Sky Sports News")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableHeaderView = newsPicker
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sports.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt IndexPath:IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? TableViewCell else {
            return UITableViewCell()
        }
        
        sports[IndexPath.row].downloadImage(completion: { (image) in
            DispatchQueue.main.async {
                cell.articleImageView?.image = image
            }
        })
        return cell
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let source = pickerData[row].apiName
        let sportsApiManager = SportsAPIManager()
        sportsApiManager.SportsSearchAPI(source: source, completion: { sports in
            self.sports = sports
            dump(sports)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
    
    // Font color for picker view
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let str = pickerData[row].displayName
        _ = UIFont.boldSystemFont(ofSize: 20)
        return NSAttributedString(string: str, attributes: [NSFontAttributeName: UIColor.darkText])
    }
    
    // Font size in picker view
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 26.0
    }
    
    // The number of columns of data in picker view
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data in picker view
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and column in picker view
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row].displayName
    }
    
    // Segue
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectIndexPath = indexPath
        let newsData = sports[indexPath.row]
        performSegue(withIdentifier: "DataInfoSegue", sender: newsData)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? NewsInfoViewController  {
            if let newsData = sender as? SportsAPI {
                destination.sports = newsData
            }
        }
    }
}
