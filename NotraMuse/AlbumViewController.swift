//
//  AlbumViewController.swift
//  NotraMuse
//
//  Created by Leonardo Osorio on 11/13/22.
//

import UIKit
import Parse

class AlbumViewController: UIViewController {
    
    //Display Album
    @IBOutlet weak var IDDezerDisplay: UILabel!
    @IBOutlet weak var NameOfAlbumDisplay: UILabel!
    @IBOutlet weak var CreatorNameDisplay: UILabel!
    
    //Delete Album
    @IBOutlet weak var AlbumIDField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "AlbumServer")
        
        query.whereKey("userID", equalTo: PFUser.current()!);
        
        query.findObjectsInBackground{ (posts, error) in
                if posts != nil {
                    print(posts! as Any)
                    self.IDDezerDisplay.text = posts![0]["albumDezID"] as? String
                    self.NameOfAlbumDisplay.text = posts![0]["nameAlbum"] as? String
                    self.CreatorNameDisplay.text = posts![0]["creatorName"] as? String
                }else{
                    print("There is not information about playlist")
                }
                    
        }
    }
    
    
    @IBAction func CreateNewAlbum(_ sender: Any) {
        var parseObject = PFObject(className:"AlbumServer")

        parseObject["albumImageURL"] = "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50?f=y"
        parseObject["nameAlbum"] = "Temporada de Diablo"
        parseObject["albumDezID"] = "1Asd1s1325"
        parseObject["userID"] = PFUser.current()!
        parseObject["creatorName"] = "Duki"

        // Saves the new object.
        parseObject.saveInBackground {
          (success: Bool, error: Error?) in
          if (success) {
              print("Correct process of creating the object of the album")
          } else {
            print("Error during the process of creating the object")
          }
        }
    }

    @IBAction func DeleteAlbum(_ sender: Any) {
        let AlbumID = AlbumIDField.text
        
        if AlbumID != nil {
            let query = PFQuery(className: "AlbumServer")
            
            query.whereKey("objectId", equalTo: AlbumID!);
            
            query.findObjectsInBackground{ (posts, error) in
                    if posts != nil {
                        print("A Album was found")
                        print(posts as Any)
                        PFObject.deleteAll(inBackground: posts) { (succeeded, error) in
                            if (succeeded) {
                                print("The matching Album was deleted")// The array of objects was successfully deleted.
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
