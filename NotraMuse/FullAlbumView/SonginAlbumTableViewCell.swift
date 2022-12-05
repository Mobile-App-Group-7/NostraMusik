//
//  SonginAlbumTableViewCell.swift
//  NotraMuse
//
//  Created by Nelson  on 11/21/22.
//

import UIKit

class SonginAlbumTableViewCell: UITableViewCell {

    @IBOutlet weak var TrackTitleLabel: UILabel!
    @IBOutlet weak var AlbumImage: UIImageView!
    @IBOutlet weak var TrackDurationLabel: UILabel!
    

    @IBAction func clickaddButton(_ sender: Any) {
        print("button clicked")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
