//
//  SinglePlaylistSongTableViewCell.swift
//  NotraMuse
//
//  Created by Nelson  on 11/22/22.
//

import UIKit

class SinglePlaylistSongTableViewCell: UITableViewCell {

    @IBOutlet weak var songTitleLabel: UILabel!
    @IBOutlet weak var AlbumImage: UIImageView!
    @IBOutlet weak var songDurationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
