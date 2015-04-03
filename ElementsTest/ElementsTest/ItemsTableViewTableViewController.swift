//
//  ItemsTableViewTableViewController.swift
//  ElementsTest
//
//  Created by luisa on 02/04/15.
//  Copyright (c) 2015 luisa. All rights reserved.
//

import UIKit
import Alamofire
import Haneke

class ItemsTableViewTableViewController: UITableViewController {
    
    let documentURL = "https://docs.google.com/spreadsheets/d/19CtR3Wuszozzpj2hj4lmcYpMPK9_c2Y9FQQsFigggeU/export?format=tsv&id=19CtR3Wuszozzpj2hj4lmcYpMPK9_c2Y9FQQsFigggeU&gid=0"
    var items = [Item]()
    let sharedApplication = UIApplication.sharedApplication()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sharedApplication.networkActivityIndicatorVisible = true
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        loadExternalData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> ItemTableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as ItemTableViewCell
        cell.itemTitle.text = items[indexPath.row].title
        cell.itemImage.image = UIImage(named: "placeholder")
        
        if let stringUrl = items[indexPath.row].image {
            let url = NSURL(string: stringUrl)
            cell.itemImage.hnk_setImageFromURL(url!)
        }
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let destinationVC = segue.destinationViewController as DetailViewController
        let indexPath = tableView.indexPathForSelectedRow() as NSIndexPath!
        destinationVC.item = items[indexPath.row]
    }
    
    
    func loadExternalData() {
        
        Alamofire.request(.GET, documentURL)
            .response { (request, response, data, error) in
                println("error \(error)")
                if error == nil {
                    let externalDataString = NSString(data: data as NSData, encoding: NSUTF8StringEncoding) as String
                    let parsedInfo = CSVReader(string: externalDataString)
                    
                    for row in parsedInfo.rows {
                        let item = Item(title: row["title"],
                            description: row["description"],
                            image: row["image"])
                        
                        self.items.append(item)
                    }
                    
                    self.tableView.reloadData()
                    self.sharedApplication.networkActivityIndicatorVisible = false
                }
        }
        
    }
    
}
