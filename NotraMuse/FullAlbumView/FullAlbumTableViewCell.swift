//
//  FullAlbumTableViewCell.swift
//  NotraMuse
//
//  Created by Nelson  on 11/21/22.
//

import UIKit

class FullAlbumTableViewCell: UITableViewCell {

    @IBOutlet weak var AlbumImage: UIImageView!
    @IBOutlet weak var AlbumTitleLabel: UILabel!
    @IBOutlet weak var ArtistNameLabel: UILabel!
    @IBOutlet weak var ArtistImage: UIImageView!
    @IBOutlet weak var AlbumReleaseDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
