//
//  detailsViewController.swift
//  Instagram
//
//  Created by Joseph Andy Feidje on 10/9/18.
//  Copyright © 2018 Softmatech. All rights reserved.
//

import UIKit
import Parse

class detailsViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var fistLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    
    var post : Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("postsss ",post)
        getDetailsData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getDetailsData() {
        if let imageFile : PFFile = post?.media {
            imageFile.getDataInBackground { (data, error) in
                if (error != nil) {
                    print(error.debugDescription)
                }
                else {
                    self.imageView.image = UIImage(data: data!)
                }
            }
        }
        fistLabel.text = post?.caption
        secondLabel.text = DateToString((post?.createdAt)!)
    }
    
    func DateToString(_ date : Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy"
        let result = formatter.string(from: date)
        return result
    }
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "loginSegue3", sender: nil)
    }
    
    
}
