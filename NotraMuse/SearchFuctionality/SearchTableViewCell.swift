//
//  SearchTableViewCell.swift
//  NotraMuse
//
//  Created by Nelly Delgado Planche on 11/19/22.
//

import UIKit
import Parse

class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var coverView: UIImageView!
    @IBOutlet weak var songLabel: UILabel!
    @IBOutlet weak var addtoplaylistButton: UIButton!
    
    var track: Song!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func AddTrackToPlaylist(_ sender: Any) {
        print("button clicked!")
        print(track.getTitle() as Any)
        print(track.getId() as Any)
        print(track.getRemoteUrl() as Any)
        print(track.getSongImageUrl() as Any)
        
        // save track on the user playlist
        /*
        let trackID = track.getId();
        let trackTitle = track.getTitle();
        let trackPreviewURL = track.getRemoteUrl();
        let trackImage = track.getSongImageUrl();
        let query = PFQuery(className: "PlaylistServer")
         
         query.whereKey("userID", equalTo: PFUser.current()!);
         
         query.findObjectsInBackground{ (playlist, error) in
                 if playlist != nil {
                     var parseObject = PFObject(className:"PlaylistAlbumTrack")

                     parseObject["userID"] = PFUser.current()!
                     parseObject["trackIDDeezer"] = trackID
                     parseObject["trackCreatorName"] = "Need"
                     parseObject["trackName"] = trackTitle
                     parseObject["trackPosterURL"] = trackImage
                     parseObject["userPlaylistAlbumID"] = playlist![0]
                     parseObject["trackPreviewURL"] = trackPreviewURL
                     parseObject["trackCreatorAlbumName"] = "Need"
                     
                     // Saves the new object.
                     parseObject.saveInBackground {
                       (success: Bool, error: Error?) in
                       if (success) {
                           print("Correct process of creating the object of the track")
                       } else {
                         print("Error during the process of creating the object")
                       }
                     }
                     
                 }else{
                     print("There is not more information of the playlist")
                 }
         }
         */
    }
    
}
