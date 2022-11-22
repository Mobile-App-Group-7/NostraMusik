//
//  AlbumViewController.swift
//  NotraMuse
//
//  Created by Nelson  on 11/21/22.
//

import UIKit

class AlbumViewController: UIViewController {

    @IBOutlet weak var AlbumCover: UIImageView!
    @IBOutlet weak var AlbumNameLabel: UILabel!
    
    @IBOutlet weak var ArtistImage: UIImageView!
    @IBOutlet weak var ArtistNameLabel: UILabel!
    @IBOutlet weak var ReleaseDateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AlbumNameLabel.font = UIFont(name: "Orbitron-Medium", size: 31)
        
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
