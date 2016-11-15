//
//  MemeViewController.swift
//  MemeMe 2.0
//
//  Created by Jaemoon Park on 11/15/16.
//
//

import Foundation
import UIKit

class MemeViewController: UIViewController{
    @IBOutlet weak var imgViewMeme: UIImageView!
    var imgMeme: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgViewMeme.image = imgMeme
    }
}
