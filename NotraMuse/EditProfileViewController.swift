//
//  EditProfileViewController.swift
//  NotraMuse
//
//  Created by Nelson  on 12/6/22.
//

import UIKit
import Alamofire
import Parse
import MBProgressHUD

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var descriptionField: UITextView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var lastNameField: UITextField!
    
    var userProfileChange: Bool! = false
    
    @IBAction func selectProfileImage(_ sender: UITapGestureRecognizer) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
        print("inside photo library call")

    }
    @IBAction func confirmProfileUpdate(_ sender: Any) {
        print("Update User Account")
        print(firstNameField.text as Any)
        print(lastNameField.text as Any)
        print(descriptionField.text as Any)
        
        let userFirstName = firstNameField.text
        let userLastName = lastNameField.text
        let userDescription = descriptionField.text
        let userImage = profileImage.image!.pngData()
        
        if userFirstName != "" && userLastName != "" && userDescription != "" {
            print("The fields are correctly filled")
            MBProgressHUD.showAdded(to: self.view, animated: true)
            //update user
            PFUser.current()!["userFirstName"] = userFirstName
            PFUser.current()!["userLastName"] = userLastName
            PFUser.current()!["userDescription"] = userDescription
                
            PFUser.current()!.saveInBackground{ (success, error) in
                    if success {
                        print("Saved new information")
                        self.UpdateUserImageProfile()
                    }else{
                        print("Error")
                    }
                }
        } else{
            print("Fields Can Not Be Empty")
        }
    }
    
    func UpdateUserImageProfile(){
        print("Check If we have user input new image")
        if userProfileChange != false {
            let userImage = profileImage.image!.pngData()
            let file = PFFileObject(name: "userPersonalizeProfile.png", data: userImage!)
            
            PFUser.current()!["personalizeProfileImage"] = file
                
            PFUser.current()!.saveInBackground{ (success, error) in
                    if success {
                        print("Saved new image information")
                        self.userProfileChange = false
                    }else{
                        print("Error during saving the user new profile")
                    }
                }
        }else{
            print("There was not image inputted, no update to user profile")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(3500)) {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000)) {
            self.navigationController?.popViewController(animated: true)
        }
    }
                
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentUser = PFUser.current()
        firstNameField.text = currentUser!["userFirstName"] as? String
        lastNameField.text = currentUser!["userLastName"] as? String
        descriptionField.text = currentUser!["userDescription"] as? String
        if currentUser!["personalizeProfileImage"] == nil {
            print("The user does not have a personalize image")
            let imageFile = PFUser.current()!["userProfileImageURL"] as! String
            let url = URL(string: imageFile)!
            
            profileImage.af.setImage(withURL: url)
        }else{
            print("We have a user personalize image")
            let imageFile = currentUser!["personalizeProfileImage"] as! PFFileObject
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            
            profileImage.af.setImage(withURL: url)
        }
        // Do any additional setup after loading the view.
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let image = info[.editedImage] as! UIImage
        let size = CGSize(width: 374, height: 350)
        let scaledImage = image.af.imageAspectScaled(toFill: size)
        
        profileImage.image = scaledImage
        
        print("User has selected an image")
        userProfileChange = true
        
        dismiss(animated: true)
        
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
