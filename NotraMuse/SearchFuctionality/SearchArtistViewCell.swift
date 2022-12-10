//
//  SearchArtistViewCell.swift
//  NotraMuse
//
//  Created by Carter Sellgren on 12/10/22.
//

import UIKit

class SearchArtistViewCell: UITableViewCell {

    var artist: Artist!
    
    @IBOutlet weak var artistName: UILabel!
    
    @IBOutlet weak var artistImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
