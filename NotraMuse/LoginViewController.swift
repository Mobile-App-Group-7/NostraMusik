//
//  LoginViewController.swift
//  NotraMuse
//
//  Created by Leonardo Osorio on 11/7/22.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func UserSignUp(_ sender: Any) {
        let user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text
        
        user.signUpInBackground{ (success, error) in
            if success {
                print("Successful Sign Up")
                self.SetUpUserInfo()
                //create userPlaylist
                self.performSegue(withIdentifier: "SuccessfulLogSIgnUser", sender: nil)
            }else{
                print("Error During Sign Up: \(error?.localizedDescription)")
            }
        }
    }
    
    func SetUpUserInfo(){
        let randomInt = Int.random(in: 1..<10000000)
        let randomDescription = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi molestie placerat mi, a iaculis massa. Duis eu ante posuere, laoreet dui nec, fermentum tortor. Nullam quis enim mattis mauris ultrices accumsan. Aliquam feugiat urna at fringilla porttitor."
        var currentUser = PFUser.current()
        if currentUser != nil {
            currentUser!["userFirstName"] = "user\(randomInt)"
            currentUser!["userLastName"] = "userLast\(randomInt)"
            currentUser!["userProfileImageURL"] = "https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp"
            currentUser!["userBackgroundImageURL"] = "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50?f=y"
            currentUser!["userDescription"] = randomDescription
            currentUser!["userLocation"] = "United States"
            currentUser!.saveInBackground() { (succeeded, error) in
                if (succeeded) {
                    print("Correctly Updated Account")// The array of objects was successfully deleted.
                    self.CreateUserPlaylist()
                } else {
                    print("Error \(error?.localizedDescription)")// There was an error. Check the errors localizedDescription.
                }
            }
        }
    }
    
    func CreateUserPlaylist() {
        var parseObject = PFObject(className:"PlaylistServer")

        parseObject["userID"] = PFUser.current()!
        parseObject["namePlaylist"] = "Your Playlist"
        parseObject["creatorName"] = PFUser.current()!.username
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
    
    
    @IBAction func UserLogin(_ sender: Any) {
        let username = usernameField.text!
        let password = passwordField.text!
        
        PFUser.logInWithUsername(inBackground: username, password: password)
            { (user, error) in
                if user != nil {
                    print("Successful Log In")
                    self.performSegue(withIdentifier: "SuccessfulLogSIgnUser", sender: nil)
                }else{
                    print("Error During Log In: \(error?.localizedDescription)")
                }
            }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
