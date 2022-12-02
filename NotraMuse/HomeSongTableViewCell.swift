//
//  HomeTableViewCell.swift
//  NotraMuse
//
//  Created by Nelson  on 11/14/22.
//

import UIKit

class HomeSongTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var RowTitleLabel: UILabel!
    var chart: ChartResult? {
        didSet {
            self.collectionView.reloadData()
        }
    }
    var indexPathVar = 0
    var parent: UIViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension HomeSongTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.chart == nil {
            return 7
        }
        
        if indexPathVar == 0 {
            return self.chart!.getSongs().count
        }
        else if indexPathVar == 1 {
            return self.chart!.getAlbums().count
        }
        else {
            return self.chart!.getArtists().count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionViewCell", for: indexPath) as! ItemCollectionViewCell
        
        if self.chart == nil {
            cell.ItemTitleLabel.text = "Loading..."
            return cell
        }
        
        if indexPathVar == 0 {
            let song = self.chart!.getSongs()[indexPath.row]
            cell.ItemTitleLabel.text = song.getTitle()
            
            if song.getSongImageUrl() != nil {
                cell.ItemImage.af.setImage(withURL: song.getSongImageUrl()!)
            }
        }
        else if indexPathVar == 1 {
            let album = self.chart!.getAlbums()[indexPath.row]
            cell.ItemImage.af.setImage(withURL: album.getCoverImageUrl()!)
            cell.ItemTitleLabel.text = album.getTitle()
        }
        else {
            let artist = self.chart!.getArtists()[indexPath.row]
            cell.ItemImage.af.setImage(withURL: artist.getProfilePictureUrl()!)
            cell.ItemTitleLabel.text = artist.getName()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height
        let width = collectionView.frame.width/3
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPathVar == 0 {
            self.parent?.performSegue(withIdentifier: "homeToTrack", sender: self.chart!.getSongs()[indexPath.row])
        }
        else if indexPathVar == 1 {
            self.parent?.performSegue(withIdentifier: "homeToAlbum", sender: self.chart!.getAlbums()[indexPath.row])
        }
        else {
            self.parent?.performSegue(withIdentifier: "homeToArtist", sender: self.chart!.getArtists()[indexPath.row])
        }
    }
}
