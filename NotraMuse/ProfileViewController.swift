//
//  ProfileViewController.swift
//  NotraMuse
//
//  Created by Leonardo Osorio on 11/8/22.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var FirstNameLabel: UILabel!
    @IBOutlet weak var UserNameLabel: UILabel!
    @IBOutlet weak var DescriptionLabel: UILabel!
    
    
    @IBOutlet weak var ChangeOfName: UITextField!
    @IBOutlet weak var ChangeOfUsername: UITextField!
    @IBOutlet weak var ChangeOfLastName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UserNameLabel.text = PFUser.current()!.username
        FirstNameLabel.text = PFUser.current()!["userFirstName"] as? String
        DescriptionLabel.text = PFUser.current()!["userDescription"] as? String
        
        print(PFUser.current()!.username!)
        print(PFUser.current()!["userFirstName"]!)
    }
    
    
    @IBAction func onLogoutButton(_ sender: Any) {
        PFUser.logOut()
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else {return}
        delegate.window?.rootViewController = loginViewController
    }
    
    
    @IBAction func UpdateUserInfo(_ sender: Any) {
        if (ChangeOfName.text != "" && ChangeOfUsername.text != "" && ChangeOfLastName.text != ""){
            PFUser.current()!["userFirstName"] = ChangeOfName.text
            PFUser.current()!.username = ChangeOfUsername.text
            PFUser.current()!["userLastName"] = ChangeOfLastName.text
            
            PFUser.current()!.saveInBackground()
        } else {
            print("Can not have empty")
        }
    }
    
    
    @IBAction func DeleteUserAccount(_ sender: Any) {
        if(PFUser.current() != nil) {
            DeleteUserAlbum()//missing delete user playlist
            let main = UIStoryboard(name: "Main", bundle: nil)
            let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else {return}
            delegate.window?.rootViewController = loginViewController
        }
    }
    
    func DeleteUserAlbum(){
        
        let query = PFQuery(className: "AlbumServer")
        
        query.whereKey("userID", equalTo: PFUser.current()!);
        
        query.findObjectsInBackground{ (posts, error) in
                if posts != nil {
                    print("A Album was found")
                    print(posts as Any)
                    PFObject.deleteAll(inBackground: posts) { (succeeded, error) in
                        if (succeeded) {
                            print("All the Albums was deleted")// The array of objects was successfully deleted.
                            self.DeleteUserPlaylist()//missing delete user albums
                        } else {
                            print("Error \(error?.localizedDescription)")// There was an error. Check the errors localizedDescription.
                        }
                    }
                }else{
                    print("Error Objects: \(error?.localizedDescription)")
                }
         }
    }
    
    func DeleteUserTracks(){
        let query = PFQuery(className: "PlaylistAlbumTrack")
        
        query.whereKey("userID", equalTo: PFUser.current()!);
        
        query.findObjectsInBackground{ (posts, error) in
                if posts != nil {
                    print("A track was found")
                    print(posts as Any)
                    PFObject.deleteAll(inBackground: posts) { (succeeded, error) in
                        if (succeeded) {
                            print("All the Tracks was deleted")// The array of objects was successfully deleted.
                            PFUser.current()!.deleteInBackground() //delete current user
                        } else {
                            print("Error \(error?.localizedDescription)")// There was an error. Check the errors localizedDescription.
                        }
                    }
                }else{
                    print("Error Objects: \(error?.localizedDescription)")
                }
         }
    }
    
    func DeleteUserPlaylist(){
        let query = PFQuery(className: "PlaylistServer")
        
        query.whereKey("userID", equalTo: PFUser.current()!);
        
        query.findObjectsInBackground{ (posts, error) in
                if posts != nil {
                    print("A playlist was found")
                    print(posts as Any)
                    PFObject.deleteAll(inBackground: posts) { (succeeded, error) in
                        if (succeeded) {
                            print("All the playlist was deleted")// The array of objects was successfully deleted.
                            self.DeleteUserTracks()//missing delete user tracks
                        } else {
                            print("Error \(error?.localizedDescription)")// There was an error. Check the errors localizedDescription.
                        }
                    }
                }else{
                    print("Error Objects: \(error?.localizedDescription)")
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
