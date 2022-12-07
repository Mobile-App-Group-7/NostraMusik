//
//  ProfileViewController.swift
//  NotraMuse
//
//  Created by Leonardo Osorio on 11/23/22.
//

import UIKit
import Parse
import AlamofireImage
import MBProgressHUD

class ProfileViewController: UIViewController, UIScrollViewDelegate{
    
    lazy var scrollView: UIScrollView = {
            let scroll = UIScrollView()
            scroll.translatesAutoresizingMaskIntoConstraints = false
            scroll.delegate = self
            scroll.contentSize = CGSize(width: self.view.frame.size.width, height: 1000)
            return scroll
    }()
    
    let user = PFUser()
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lastnameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
            let currentUser = PFUser.current()
            self.usernameLabel.text = currentUser?.username
            self.nameLabel.text = currentUser!["userFirstName"] as? String
            self.lastnameLabel.text = currentUser!["userLastName"] as? String
            self.locationLabel.text = currentUser!["userLocation"] as? String
            self.descriptionLabel.text = currentUser!["userDescription"] as? String
            
            if currentUser!["personalizeProfileImage"] == nil {
                print("The user does not have a personalize image")
                let imageFile = PFUser.current()!["userProfileImageURL"] as! String
                let url = URL(string: imageFile)!
                
                self.profileImg.af.setImage(withURL: url)
            }else{
                print("We have a user personalize image")
                let imageFile = currentUser!["personalizeProfileImage"] as! PFFileObject
                let urlString = imageFile.url!
                let url = URL(string: urlString)!
                
                self.profileImg.af.setImage(withURL: url)
            }
            
            self.descriptionLabel.adjustsFontSizeToFitWidth = true
            self.descriptionLabel.minimumScaleFactor=0.5
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
    @IBAction func userOnLogOut(_ sender: Any) {
        PFUser.logOut()
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else {return}
        delegate.window?.rootViewController = loginViewController
    }
    
    
    @IBAction func DeleteUserAccount(_ sender: Any) {
        print("Delete User Account")
        if(PFUser.current() != nil) {
            MBProgressHUD.showAdded(to: self.view, animated: true)
            DeleteUserAlbum()
            let main = UIStoryboard(name: "Main", bundle: nil)
            let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else {return}
            delegate.window?.rootViewController = loginViewController
        }else{
            print("Not User Sign Up")
        }
    }
    
    func DeleteUserAlbum() {
        
        let query = PFQuery(className: "AlbumServer")
        
        query.whereKey("userID", equalTo: PFUser.current()!);
        
        query.findObjectsInBackground{ (albums, error) in
                if albums != nil {
                    print("Successful Connection")
                    print(albums as Any)
                    PFObject.deleteAll(inBackground: albums) { (succeeded, error) in
                        if (succeeded) {
                            print("All the Albums was deleted")// The array of objects was successfully deleted.
                        } else {
                            print("Error \(error?.localizedDescription)")// There was an error. Check the errors localizedDescription.
                        }
                        self.DeleteUserTracks()//missing delete user tracks
                    }
                }else{
                    print("Error Objects: \(error?.localizedDescription)")
                }
         }
    }
    
    func DeleteUserTracks(){
        let query = PFQuery(className: "PlaylistAlbumTrack")
        
        query.whereKey("userID", equalTo: PFUser.current()!);
        
        query.findObjectsInBackground{ (tracks, error) in
                if tracks != nil {
                    print("Successful connection")
                    print(tracks as Any)
                    PFObject.deleteAll(inBackground: tracks) { (succeeded, error) in
                        if (succeeded) {
                            print("All the Tracks was deleted")// The array of objects was successfully deleted.
                        } else {
                            print("Error \(error?.localizedDescription)")// There was an error. Check the errors localizedDescription.
                        }
                        self.DeleteUserPlaylist()//missing delete user albums
                    }
                }else{
                    print("Error Objects: \(error?.localizedDescription)")
                }
         }
    }
    
    func DeleteUserAccount() {
        if PFUser.current() != nil {
            PFUser.current()!.deleteInBackground(block: { (deleteSuccessful, error) -> Void in
                MBProgressHUD.hide(for: self.view, animated: true)
                    print("success = \(deleteSuccessful)")
                    PFUser.logOut()
                })
        }
    }
    
    func DeleteUserPlaylist(){
        let query = PFQuery(className: "PlaylistServer")
        
        query.whereKey("userID", equalTo: PFUser.current()!);
        
        query.findObjectsInBackground{ (playlists, error) in
                if playlists != nil {
                    print("Successful Connection")
                    print(playlists as Any)
                    PFObject.deleteAll(inBackground: playlists) { (succeeded, error) in
                        if (succeeded) {
                            print("All the playlist was deleted")// The array of objects was successfully deleted.
                        } else {
                            print("Error \(error?.localizedDescription)")// There was an error. Check the errors localizedDescription.
                        }
                        self.DeleteUserAccount()
                    }
                }else{
                    print("Error Objects: \(error?.localizedDescription)")
                }
         }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let layout = view.safeAreaLayoutGuide
        scrollView.centerXAnchor.constraint(equalTo: layout.centerXAnchor).isActive = true
        scrollView.centerYAnchor.constraint(equalTo: layout.centerYAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: layout.widthAnchor).isActive = true
        scrollView.heightAnchor.constraint(equalTo: layout.heightAnchor).isActive = true
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
