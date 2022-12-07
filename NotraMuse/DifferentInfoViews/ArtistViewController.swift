//
//  ArtistViewController.swift
//  NotraMuse
//
//  Created by user204225 on 11/15/22.
//

import UIKit

class ArtistViewController: UIViewController {

    
    @IBOutlet weak var artistLabel: UIImageView!
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    @IBOutlet weak var numfansLabel: UILabel!
    
    
    @IBOutlet weak var numalbumLabel: UILabel!
    
    var artist: Artist?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            let (art, error) = await Deezer.shared.fetchArtist(artistId: String(artist!.getId()))
            if error != nil {
                print("Error with deezer api: \(String(describing: error))")
            }
            else {
                let number = art!.getNumFans()! 
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                let formattedNum = numberFormatter.string(from: NSNumber(value:number))
                numfansLabel.text = formattedNum
                artistLabel.af.setImage(withURL: art!.getProfilePictureUrl()!)
                nameLabel.text = art!.getName()
                numalbumLabel.text = String(art!.getNumAlbums()!)
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
