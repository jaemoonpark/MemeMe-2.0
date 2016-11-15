//
//  MemeTableViewCell.swift
//  MemeMe 2.0
//
//  Created by Jaemoon Park on 11/15/16.
//
//

import UIKit

class MemeTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTop: UILabel!
    @IBOutlet weak var lblBtm: UILabel!
    @IBOutlet weak var memeImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
