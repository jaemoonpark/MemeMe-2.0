//
//  MemeTableViewController.swift
//  MemeMe 2.0
//
//  Created by Jaemoon Park on 11/14/16.
//
//

import Foundation
import UIKit
class MemeTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    var memes: [Meme]!
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todo")!
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
}
