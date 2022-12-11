//
//  SearchTableViewCell.swift
//  NotraMuse
//
//  Created by Nelly Delgado Planche on 11/19/22.
//

import UIKit
import Parse

protocol CellDelegate: AnyObject{
    func playSong(Track: Song!)
}

class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var coverView: UIImageView!
    @IBOutlet weak var songLabel: UILabel!
    @IBOutlet weak var addtoplaylistButton: UIButton!
    
    @IBOutlet weak var authorLabel: UILabel!
    
    
    var track: Song!
    
    weak var delegate: CellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    @IBAction func playSong(_ sender: Any) {
//        delegate?.playSong()
//    }
    @IBAction func playSong( _ sender: Any) {
        self.delegate?.playSong(Track: track)
        print("Button clicked inside tableview cell file now")
    }
    
    @IBAction func AddTrackToPlaylist(_ sender: Any) {
        print("button clicked!")
        print(track.getTitle() as Any)
        print(track.getId() as Any)
        print(track.getRemoteUrl() as Any)
        print(track.getSongImageUrl() as Any)
        print(track.getAlbumName() as Any)
        print(track.getArtistName() as Any)
        print(track.getSongDuration() as Any)
        
        // save track on the user playlist
        
        if track != nil{
            
            let trackID = "\(track.getId())"; //ID Deezer
            let trackTitle = track.getTitle(); // track name
            let trackPreviewURL = track.getRemoteUrl(); //track preview
            let trackImage = track.getSongImageUrl()?.absoluteString; //track poster
            let trackArtist = track.getArtistName(); // track artist
            let trackAlbumName = track.getAlbumName(); //track album name
            let trackDuration = track.getSongDuration(); // track duration time
            
            //check if the track is already saved on the playlist
            let queryCheck = PFQuery(className: "PlaylistAlbumTrack")
            queryCheck.whereKey("trackIDDeezer", equalTo: trackID);
            queryCheck.whereKey("userID", equalTo: PFUser.current()!);
            
            queryCheck.findObjectsInBackground{ (tracksMatch, error) in
                if tracksMatch != nil {
                    if tracksMatch?.count == 0 {
                        print("It does not exist a matching track, adding the track")
                        //add the track
                        let query = PFQuery(className: "PlaylistServer")
                         
                         query.whereKey("userID", equalTo: PFUser.current()!);
                         
                         query.findObjectsInBackground{ (playlist, error) in
                                 if playlist != nil {
                                     let parseObject = PFObject(className:"PlaylistAlbumTrack")

                                     parseObject["userID"] = PFUser.current()!
                                     parseObject["trackIDDeezer"] = trackID
                                     parseObject["trackCreatorName"] = trackArtist
                                     parseObject["trackName"] = trackTitle
                                     parseObject["trackPosterURL"] = trackImage
                                     parseObject["userPlaylistAlbumID"] = playlist![0]
                                     parseObject["trackPreviewURL"] = "\(trackPreviewURL)"
                                     parseObject["trackCreatorAlbumName"] = trackAlbumName
                                     parseObject["trackDurationTime"] = trackDuration
                                     
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
                    }else{
                        print("There exist a matching track, it can not be added the track, it will create a duplicate")
                    }
                }else{
                    print("Error during the check of the track")
                }
            }
            
        }else{
            print("Track Not Received Not Able To Be Saved")
        }
        //finish check and adding of track
    }
}
