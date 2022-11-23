//
//  ItemCollectionViewCell.swift
//  NotraMuse
//
//  Created by Nelson  on 11/21/22.
//
import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var ItemTitleLabel: UILabel!
    @IBOutlet weak var ItemImage: UIImageView!
    
    var indexPath: IndexPath = []
}
