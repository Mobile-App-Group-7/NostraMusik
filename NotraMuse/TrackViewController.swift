//
//  TrackViewController.swift
//  NotraMuse
//
//  Created by Leonardo Osorio on 11/14/22.
//

import UIKit
import Parse

class TrackViewController: UIViewController {
    
    //Display
    @IBOutlet weak var TrackIDDisplay: UILabel!
    @IBOutlet weak var trackNameDisplay: UILabel!
    @IBOutlet weak var trackAlbumNameDisplay: UILabel!
    
    //Delete
    @IBOutlet weak var TrackIDPlaceHolder: UITextField!
    
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
                    
                    let query = PFQuery(className: "PlaylistAlbumTrack")
                    
                    query.whereKey("userID", equalTo: PFUser.current()!);
                    query.whereKey("userPlaylistAlbumID", equalTo: posts![0]);
                    
                    query.findObjectsInBackground{ (posts, error) in
                            if posts != nil {
                                print(posts! as Any)
                                self.TrackIDDisplay.text = posts![0]["trackIDDeezer"] as? String
                                self.trackNameDisplay.text = posts![0]["trackName"] as? String
                                self.trackAlbumNameDisplay.text = posts![0]["trackCreatorAlbumName"] as? String
                            }else{
                                print("There is not tracks on the playlist")
                            }
                    }
                }else{
                    print("There is not playlist")
                }
        }
    }
    
    @IBAction func AddTrack(_ sender: Any) {
        let query = PFQuery(className: "PlaylistServer")
        
        query.whereKey("userID", equalTo: PFUser.current()!);
        
        query.findObjectsInBackground{ (posts, error) in
                if posts != nil {
                    var parseObject = PFObject(className:"PlaylistAlbumTrack")

                    parseObject["userID"] = PFUser.current()!
                    parseObject["trackIDDeezer"] = "1Asd1s1325"
                    parseObject["trackCreatorName"] = "Duki"
                    parseObject["trackName"] = "Movimiento"
                    parseObject["trackPosterURL"] = "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50?f=y"
                    parseObject["userPlaylistAlbumID"] = posts![0]
                    parseObject["trackPreviewURL"] = "https://www.youtube.com/watch?v=eFn2RIH6qz8"
                    parseObject["trackCreatorAlbumName"] = "Temporada de Regueton"
                    
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
                    print("There is not more information")
                }
        }
    }
    
    
    @IBAction func DeleteTrack(_ sender: Any) {
        let TrackID = TrackIDPlaceHolder.text
        
        if TrackID != nil {
            let query = PFQuery(className: "PlaylistAlbumTrack")
            
            query.whereKey("objectId", equalTo: TrackID!);
            
            query.findObjectsInBackground{ (posts, error) in
                    if posts != nil {
                        print("A Track was found")
                        print(posts as Any)
                        PFObject.deleteAll(inBackground: posts) { (succeeded, error) in
                            if (succeeded) {
                                print("The matching track was deleted")// The array of objects was successfully deleted.
                            } else {
                                print("Error \(error?.localizedDescription)")// There was an error. Check the errors localizedDescription.
                            }
                        }
                    }else{
                        print("Error Objects: \(error?.localizedDescription)")
                    }
             }
        }else{
            print("You are not able to delete, you need to give text")
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
