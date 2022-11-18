//
//  PlaylistViewController.swift
//  NotraMuse
//
//  Created by Leonardo Osorio on 11/12/22.
//

import UIKit
import Parse

class PlaylistViewController: UIViewController {
    
    //Display Parse Server
    @IBOutlet weak var PlaylistIDDisplay: UILabel!
    @IBOutlet weak var PlaylistNameDisplay: UILabel!
    @IBOutlet weak var CreatorNamePlaylistDisplay: UILabel!
    
    //Delete Parse Server
    @IBOutlet weak var DeletePlaylistIDLabel: UITextField!
    
    //Update Parse Server
    @IBOutlet weak var NamePlaylistLabel: UITextField!
    @IBOutlet weak var PlaylistURLLabel: UITextField!
    @IBOutlet weak var PlaylistIDLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "PlaylistServer")
        
        query.whereKey("userID", equalTo: PFUser.current()!);
        
        query.findObjectsInBackground{ (posts, error) in
                if posts != nil {
                    print(posts! as Any)
                    self.PlaylistIDDisplay.text = posts![0].objectId
                    self.PlaylistNameDisplay.text = posts![0]["namePlaylist"] as? String
                    self.CreatorNamePlaylistDisplay.text = posts![0]["creatorName"] as? String
                }else{
                    print("There is not more information")
                }
                    
        }
    }

    @IBAction func CreateNewPlaylist(_ sender: Any) {
        var parseObject = PFObject(className:"PlaylistServer")

        parseObject["userID"] = PFUser.current()!
        parseObject["namePlaylist"] = "Random Playlist"
        parseObject["creatorName"] = PFUser.current()!.username
        parseObject["playlistImageURL"] = "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50?f=y"

        // Saves the new object.
        parseObject.saveInBackground {
          (success: Bool, error: Error?) in
          if (success) {
              print("Successful Creation Of New Playlist")
          } else {
            print("Error during the process of creating the object")
          }
        }
    }
    
    
    @IBAction func DeletePlaylist(_ sender: Any) {
        let PlaylistID = DeletePlaylistIDLabel.text
        
        if PlaylistID != nil {
            let query = PFQuery(className: "PlaylistServer")
            
            query.whereKey("objectId", equalTo: PlaylistID!);
            
            query.findObjectsInBackground{ (posts, error) in
                if posts != nil {
                    print("The playlist was found")
                    print(posts as Any)
                    self.DeleteTracksPlaylist(posts!)
                }else{
                    print("Error Objects: \(error?.localizedDescription)")
                }
            }
        }
    }
    
    func DeleteTracksPlaylist(_ postse: [PFObject]) {
        let query = PFQuery(className: "PlaylistAlbumTrack")
        
        query.whereKey("userPlaylistAlbumID", equalTo: postse[0]);
        
        query.findObjectsInBackground{ (posts, error) in
                if posts != nil {
                    print("A track was found")
                    print(posts as Any)
                    PFObject.deleteAll(inBackground: posts) { (succeeded, error) in
                        if (succeeded) {
                            print("All tracks Deleted")// The array of objects was successfully deleted.
                        } else {
                            print("Error \(error?.localizedDescription)")// There was an error. Check the errors localizedDescription.
                        }
                        self.DeleteUserPlaylist(postse)
                    }
                }else{
                    print("Error Objects: \(error?.localizedDescription)")
                }
         }
    }
    
    func DeleteUserPlaylist(_ posts: [PFObject]) {
        let query = PFQuery(className: "PlaylistServer")
        
        PFObject.deleteAll(inBackground: posts) { (succeeded, error) in
            if (succeeded) {
                print("All playlist Deleted")// The array of objects was successfully deleted.
            } else {
                print("Error \(error?.localizedDescription)")// There was an error. Check the errors localizedDescription.
            }
            
        }
    }
    
    
    @IBAction func UpdatePlaylist(_ sender: Any) {
        let PlaylistName = NamePlaylistLabel.text
        let PlaylistImageURL = PlaylistURLLabel.text
        let PlaylistID = PlaylistIDLabel.text
        
        if PlaylistName != nil && PlaylistImageURL != nil && PlaylistID != nil{
            let query = PFQuery(className:"PlaylistServer")
            
            query.getObjectInBackground(withId: PlaylistID!) { (parseObject, error) in
              if error != nil {
                print(error)
              } else if parseObject != nil {
                  print("Sucessful Found of the Playlist and Update")
                  print(parseObject!)
                  parseObject!["namePlaylist"] = PlaylistName
                  parseObject!["playlistImageURL"] = "https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp"

                  parseObject!.saveInBackground()
              }
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
