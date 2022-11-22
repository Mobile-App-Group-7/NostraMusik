//
//  HomeTableViewCell.swift
//  NotraMuse
//
//  Created by Nelson  on 11/14/22.
//

import UIKit

class HomeSongTableViewCell: UITableViewCell {

    @IBOutlet weak var RowLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var indexPathVar: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension HomeSongTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionViewCell", for: indexPath) as! ItemCollectionViewCell
        cell.ItemTitleLabel.text = "Song Name New"
        /*let imageURL = URL(string: "")
        let data = try? Data(contentsOf: imageURL!)
        if let imageData = data{
            cell.imageView.image = UIImage(data: imageData)
        }
         */
            
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height
        let width = collectionView.frame.width/3
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPathVar)")
        
    }

}
