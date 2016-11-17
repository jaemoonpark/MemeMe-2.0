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
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    //adding outlet in order to call reloadData
    @IBOutlet weak var collectionMeme: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        let space: CGFloat = 3.0
        let dimension = (self.view.frame.size.width - (2  * space)) / 3.0
        flowLayout.minimumLineSpacing = space
        flowLayout.minimumInteritemSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        memes = appDelegate.memes
        collectionMeme.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath) as! MemeCollectionViewCell
        //setting imageview to fill up entire cell. setting origin to itself in order to preserve location-- using cell.frame.origin overlaps cells because cell frame has not been properly set yet(?)
        cell.memeImageView?.frame = CGRect(origin: cell.memeImageView.frame.origin, size: cell.frame.size)
        
        cell.memeImageView?.image  = memes[indexPath.row].imageFinal
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let memeViewController = self.storyboard!.instantiateViewController(withIdentifier: "MemeViewController") as! MemeViewController
        memeViewController.meme = memes[indexPath.row]
        self.navigationController!.pushViewController(memeViewController, animated: true)
    }
}
