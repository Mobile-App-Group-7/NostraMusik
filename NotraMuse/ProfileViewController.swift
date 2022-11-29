//
//  ProfileViewController.swift
//  NotraMuse
//
//  Created by Leonardo Osorio on 11/23/22.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {
    

    let user = PFUser()
    
    @IBOutlet weak var profileImg: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var lastnameLabel: UILabel!
    
    
    @IBOutlet weak var locationLabel: UILabel!
    
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let currentUser = PFUser.current()
        usernameLabel.text = currentUser?.username
        nameLabel.text = "Harvey"
        lastnameLabel.text = "Machado"
        locationLabel.text="Peru"
        descriptionLabel.text = "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur."
        descriptionLabel.adjustsFontSizeToFitWidth = true
        descriptionLabel.minimumScaleFactor=0.5
        // Do any additional setup after loading the view.
    }
    
    @IBAction func userOnLogOut(_ sender: Any) {
        PFUser.logOut()
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else {return}
        delegate.window?.rootViewController = loginViewController
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
