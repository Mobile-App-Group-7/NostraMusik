//
//  PlaylistsTableViewCell.swift
//  NotraMuse
//
//  Created by Nelson  on 11/22/22.
//

import UIKit

class PlaylistsTableViewCell: UITableViewCell {

    @IBOutlet weak var playlistImage: UIImageView!
    @IBOutlet weak var playlistName: UILabel!
    @IBOutlet weak var createrNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
