//
//  SinglePlaylistInfoTableViewCell.swift
//  NotraMuse
//
//  Created by Nelson  on 11/22/22.
//

import UIKit

class SinglePlaylistInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var playlistLabel: UILabel!
    @IBOutlet weak var playlistImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
