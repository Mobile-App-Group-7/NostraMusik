//
//  LoginViewController.swift
//  NotraMuse
//
//  Created by Nelson  on 11/14/22.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var AppNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AppNameLabel.font = UIFont(name: "Orbitron-Medium", size: 35)
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [0/255,0/255,0/255,0.85]) as Any, CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [152/255,38/255,226/255,1]) as Any, CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [0/255,0/255,0/255,1]) as Any]
        gradientLayer.locations = [0.12,0.30,0.45]

        self.view.layer.insertSublayer(gradientLayer, at: 0)
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func userSignIn(_ sender: Any) {
        let username = usernameField.text
        let password = passwordField.text
        
        if username != nil && password != nil {
            
            PFUser.logInWithUsername(inBackground: username!, password: password!)
                { (user, error) in
                    if user != nil {
                        print("Successful Log In")
                        self.performSegue(withIdentifier: "SuccessfulLogSIgnUser", sender: nil)
                    }else{
                        print("Error During Log In: \(error?.localizedDescription)")
                    }
                }
        }else{
            print("Sorry can not be empty your fields")
        }
    }
    
    @IBAction func userSignUp(_ sender: Any) {
        let username = usernameField.text
        let password = passwordField.text
        
        if username != nil && password != nil {
            
            let user = PFUser()
            user.username = username
            user.password = password
            
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
        }else{
            print("Sorry can not be empty your fields")
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
