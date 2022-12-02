//
//  TrackViewController.swift
//  NotraMuse
//
//  Created by user204225 on 11/15/22.
//

import UIKit

class TrackViewController: UIViewController {
    
    
    @IBOutlet weak var trackimg: UIImageView!
    
    
    @IBOutlet weak var nameLabl: UILabel!
    
    
    @IBOutlet weak var rankLabel: UILabel!
    
    
    @IBOutlet weak var artistnameLabel: UILabel!
    
    
    @IBOutlet weak var releaseLabel: UILabel!
    
    
    @IBOutlet weak var tracknumLabel: UILabel!
    
    
    var track: Song?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if track?.getRank() != nil {
            rankLabel.text = String(track!.getRank()!)
        }
        
        nameLabl.text = track?.getTitle()
        artistnameLabel.text = track?.getArtistName()
        trackimg.af.setImage(withURL: (track?.getSongImageUrl())!)
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
