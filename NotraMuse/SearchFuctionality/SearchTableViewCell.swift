//
//  SearchTableViewCell.swift
//  NotraMuse
//
//  Created by Nelly Delgado Planche on 11/19/22.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var coverView: UIImageView!
    
    @IBOutlet weak var songLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
