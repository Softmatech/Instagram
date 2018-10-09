//
//  secondViewController.swift
//  Instagram
//
//  Created by Joseph Andy Feidje on 10/8/18.
//  Copyright © 2018 Softmatech. All rights reserved.
//

import UIKit
import Parse

class secondViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    var refreshControl: UIRefreshControl!
    var window: UIWindow?
    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        indicatorSet()
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(secondViewController.didPullTorefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
//        tableView.rowHeight = UITableViewAutomaticDimension
//        tableView.estimatedRowHeight = 50
        tableView.rowHeight = 400
        tableView.delegate = self
        tableView.dataSource = self
        self.fetchPosts()
    }
    
    
    
    @IBAction func didTapGesture(_ sender: Any) {
//        performSegue(withIdentifier: "detailsSegue", sender: nil)
    
    }
    
    @objc func didPullTorefresh(_ refreshControl: UIRefreshControl){
        fetchPosts()
    }
    
    func indicatorSet(){
        if indicatorView.isAnimating == true {
            indicatorView.stopAnimating()
            indicatorView.isHidden = true
        }
        else{
            indicatorView.isHidden = true
            indicatorView.startAnimating()
        }
    }
    

    
    @objc func fetchPosts() {
        // Create New PFQuery
        let query = Post.query()
        query?.includeKey("createdAt")
        query?.includeKey("author")
        query?.order(byDescending: "createdAt")
        query?.limit = 20
        // Fetch data asynchronously
        query?.findObjectsInBackground(block: { (posts, error) in
            if error != nil {
                print("-------->>>> ",error.debugDescription)
            }
            else{
                                self.indicatorView.startAnimating()
                            if let posts = posts {
                                self.posts = posts as! [Post]
                                self.indicatorView.stopAnimating()
                                self.tableView.reloadData()
                                self.refreshControl.endRefreshing()
            }
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func lougOut(_ sender: UIBarButtonItem) {
        NotificationCenter.default.post(name: NSNotification.Name("didLogout"), object: nil)
    }
    
    func logout(){
        PFUser.logOutInBackground { (error: Error?) in
            if error != nil {
                print(error?.localizedDescription)
            }
            else{
                print("Logout Successfully")
                // Load and show the login view controller
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let loginViewController = storyboard.instantiateViewController(withIdentifier: "loginViewController")
                self.window?.rootViewController = loginViewController
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        let post = posts[indexPath.row]
//        cell.indexPath = indexPath
        if let imageFile : PFFile = post.media {
            imageFile.getDataInBackground { (data, error) in
                if (error != nil) {
                    print(error.debugDescription)
                }
                else {
                    cell.imageViewPost.image = UIImage(data: data!)
                    
                }
            }
        }
        cell.textViewPost.text = post.caption
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailSegue = segue.destination as? detailsViewController
        if let cell = sender as! PostCell? {
            detailSegue?.post = posts[(cell.indexPath?.row)!]
            print("yesss")
        }
    }
    
}
