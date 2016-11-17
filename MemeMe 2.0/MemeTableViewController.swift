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
    
    override func viewWillAppear(_ animated: Bool) {
        //updating meme on viewWillAppear so meme properly updates when exiting meme editor
        memes = appDelegate.memes
        tblMeme.reloadData()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableViewCell")! as! MemeTableViewCell
        cell.memeImageView?.image = memes[indexPath.row].imageFinal
        cell.lblTop?.text = memes[indexPath.row].strTop
        cell.lblBtm?.text = memes[indexPath.row].strBtm
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let memeViewController = self.storyboard!.instantiateViewController(withIdentifier: "MemeViewController") as! MemeViewController
        memeViewController.imgMeme = memes[indexPath.row].imageFinal
        self.navigationController!.pushViewController(memeViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == UITableViewCellEditingStyle.delete){
            memes.remove(at: indexPath.row)
            //removing directly from appdelegate memes causes error so setting it equal to modified local meme array.
            appDelegate.memes = memes
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    
}
