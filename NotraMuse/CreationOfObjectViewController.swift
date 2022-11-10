//
//  CreationOfObjectViewController.swift
//  NotraMuse
//
//  Created by Leonardo Osorio on 11/8/22.
//

import UIKit
import Parse
import AlamofireImage

class CreationOfObjectViewController: UIViewController {
    
    @IBOutlet weak var DisplayUserProfile: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageFile = PFUser.current()!["userProfileImageURL"] as! String
        let url = URL(string: imageFile)!
        
        DisplayUserProfile.af.setImage(withURL: url)
        
        //DisplayUserProfile.setImage(withURL: )
        // Do any additional setup after loading the view.
    }
    

    @IBAction func CreationOfPlaylist(_ sender: Any) {
        var parseObject = PFObject(className:"PlaylistServer")

        parseObject["userID"] = PFUser.current()!
        parseObject["namePlaylist"] = "Your Playlist"
        parseObject["creatorName"] = "you"
        parseObject["playlistImageURL"] = "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50?f=y"

        // Saves the new object.
        parseObject.saveInBackground {
          (success: Bool, error: Error?) in
          if (success) {
              print("Correct process of creating the object")
          } else {
            print("Error during the process of creating the object")
          }
        }
    }
    
    
    @IBAction func CreationOfTrack(_ sender: Any) {
        
        let query = PFQuery(className: "PlaylistServer")
        
        query.whereKey("userID", equalTo: PFUser.current()!);
        
        query.findObjectsInBackground{ (posts, error) in
                if posts != nil {
                    print(posts![0] as Any)
                    
                    var parseObject = PFObject(className:"PlaylistAlbumTrack")

                    parseObject["userID"] = PFUser.current()!
                    parseObject["userPlaylistAlbumID"] = posts![0]
                    parseObject["trackIDDeezer"] = "1345Adassd135135"
                    parseObject["trackName"] = "Hello"
                    parseObject["trackPreviewURL"] = "-"
                    parseObject["trackCreatorName"] = "Illo"
                    parseObject["trackPosterURL"] = "-"
                    parseObject["trackCreatorAlbumName"] = "Joao"

                    // Saves the new object.
                    parseObject.saveInBackground {
                      (success: Bool, error: Error?) in
                      if (success) {
                          print("Correct process of creating the object")
                      } else {
                        print("Error during the process of creating the object")
                      }
                    }
                    
                }
            }
    }
    
    
    @IBAction func CreationOfAlbum(_ sender: Any) {
        var parseObject = PFObject(className:"AlbumServer")

        parseObject["userID"] = PFUser.current()!
        parseObject["albumDezID"] = "1345Adassd135135"
        parseObject["nameAlbum"] = "Hello"
        parseObject["creatorName"] = "None"
        parseObject["albumImageURL"] = "-"

        // Saves the new object.
        parseObject.saveInBackground {
          (success: Bool, error: Error?) in
          if (success) {
              print("Correct process of creating the object")
          } else {
            print("Error during the process of creating the object")
          }
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
