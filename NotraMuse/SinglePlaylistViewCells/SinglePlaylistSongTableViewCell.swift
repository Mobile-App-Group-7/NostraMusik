//
//  SinglePlaylistSongTableViewCell.swift
//  NotraMuse
//
//  Created by Nelson  on 11/22/22.
//

import UIKit
import Parse

protocol CellDeleteDelegate: AnyObject{
    func Deletrack()
}

class SinglePlaylistSongTableViewCell: UITableViewCell {

    @IBOutlet weak var songTitleLabel: UILabel!
    @IBOutlet weak var AlbumImage: UIImageView!
    @IBOutlet weak var songDurationLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    
    var track: PFObject!
    
    weak var delegate: CellDeleteDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func DeleteTrackPlaylist(_ sender: Any) {
        print(track as Any)
        
        PFObject.deleteAll(inBackground: [track]) { (succeeded, error) in
            if (succeeded) {
                print("it was successful the deletion of the track")// The array of objects was successfully deleted.
                self.delegate?.Deletrack()
            } else {
                print("it was unsucessful the deletion of the track")// There was an error. Check the errors localizedDescription.
            }
        }
    }
    
}
