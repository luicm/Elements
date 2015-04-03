//
//  DetailViewController.swift
//  ElementsTest
//
//  Created by luisa on 03/04/15.
//  Copyright (c) 2015 luisa. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailDescription: UILabel!
    
    var item:Item!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        detailDescription.text = item.description
        if let imageURL = item.image {
            let url =  NSURL(string: imageURL)
            detailImage.hnk_setImageFromURL(url!)
        }
        
        self.navigationItem.title = item.title
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
