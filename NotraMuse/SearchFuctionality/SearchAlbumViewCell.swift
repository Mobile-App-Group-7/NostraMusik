//
//  SearchAlbumViewCell.swift
//  NotraMuse
//
//  Created by Carter Sellgren on 12/10/22.
//

import UIKit

class SearchAlbumViewCell: UITableViewCell {

    
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var albumImage: UIImageView!
    
    var album: Album!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
