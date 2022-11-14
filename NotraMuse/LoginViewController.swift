//
//  LoginViewController.swift
//  NotraMuse
//
//  Created by Nelson  on 11/14/22.
//

import UIKit

class LoginViewController: UIViewController {

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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
