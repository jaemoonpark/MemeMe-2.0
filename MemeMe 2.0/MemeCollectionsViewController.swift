//
//  MemeCollectionsViewController.swift
//  MemeMe 2.0
//
//  Created by Jaemoon Park on 11/14/16.
//
//

import Foundation
import UIKit
class MemeCollectionsViewController: UICollectionViewController{
    var memes: [Meme]!
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
    }
}
