//
//  TrackViewController.swift
//  NotraMuse
//
//  Created by user204225 on 11/15/22.
//

import UIKit
import Parse

class TrackViewController: UIViewController {
    
    @IBOutlet weak var trackimg: UIImageView!
    @IBOutlet weak var nameLabl: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var artistnameLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var tracknumLabel: UILabel!
    @IBOutlet weak var ablumLabel: UILabel!
    
    var track: Song?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if track?.getRank() != nil {
            rankLabel.text = String(track!.getRank()!)
        }
        
        nameLabl.text = track?.getTitle()
        artistnameLabel.text = track?.getArtistName()
        trackimg.af.setImage(withURL: (track?.getSongImageUrl())!)
        //tracknumLabel.text =
        //releaseLabel.text
        ablumLabel.text = track?.getAlbumName()
        
    }
    
    @IBAction func playSongButton(_ sender: Any) {
        print("pressing play button")
        performSegue(withIdentifier: "songInfotoPlayer", sender: nil)
    }
    
    @IBAction func addSongtoPlaylistButton(_ sender: Any) {
        print("Saving song to playlist button")
        print(track?.getTitle() as Any)
        print(track?.getId() as Any)
        print(track?.getRemoteUrl() as Any)
        print(track?.getSongImageUrl() as Any)
        print(track?.getAlbumName() as Any)
        print(track?.getArtistName() as Any)
        print(track?.getSongDuration() as Any)
        
        // save track on the user playlist
        if track != nil{
            let trackID = "\(track!.getId())"; //ID Deezer
            let trackTitle = track!.getTitle(); // track name
            let trackPreviewURL = track!.getRemoteUrl(); //track preview
            let trackImage = track!.getSongImageUrl()?.absoluteString; //track poster
            let trackArtist = track!.getArtistName(); // track artist
            let trackAlbumName = track!.getAlbumName(); //track album name
            let trackDuration = track!.getSongDuration(); // track duration time

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
            print("Track Not Received Not Able To Be Saved")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "songInfotoPlayer" {
            let PVC = segue.destination as! PlayerViewController
            PVC.track = track!.getTitle()
            PVC.imageURL = track!.getSongImageUrl()!.absoluteString
            PVC.artistName = track!.getArtistName()!
            PVC.previewTrackURL = track!.getRemoteUrl().absoluteString
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
