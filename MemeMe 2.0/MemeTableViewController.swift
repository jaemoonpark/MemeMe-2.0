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
    //adding outlet in order to call reloadData
    @IBOutlet weak var tblMeme: UITableView!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //updating meme on viewWillAppear so meme properly updates when exiting meme editor
        memes = appDelegate.memes
        tblMeme.reloadData()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableCell")!
        cell.imageView?.image = memes[indexPath.row].imageFinal
        cell.textLabel?.text = memes[indexPath.row].strTop
        cell.detailTextLabel?.text = memes[indexPath.row].strBtm
        return cell
    }
    
}
