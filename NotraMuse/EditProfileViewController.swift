//
//  EditProfileViewController.swift
//  NotraMuse
//
//  Created by Nelson  on 12/6/22.
//

import UIKit
import Alamofire

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var descriptionField: UITextView!
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var lastNameField: UITextField!
    
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
        _ = navigationController?.popViewController(animated: true)
    }
                
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let image = info[.editedImage] as! UIImage
        let size = CGSize(width: 374, height: 350)
        let scaledImage = image.af.imageAspectScaled(toFill: size)
        
        profileImage.image = scaledImage
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
