//
//  SinglePlaylistViewController.swift
//  NotraMuse
//
//  Created by Nelson  on 11/22/22.
//

import UIKit
import Parse
import AlamofireImage

class SinglePlaylistViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var playlist: PFObject!
    var tracks = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        print("On the new detail page")
        print(playlist as Any)
        userTrackPlaylist()
        // Do any additional setup after loading the view.
    }
    
    func userTrackPlaylist(){
        let query = PFQuery(className: "PlaylistAlbumTrack")
        
        query.whereKey("userID", equalTo: PFUser.current()!);
        query.whereKey("userPlaylistAlbumID", equalTo: playlist!);
        
        query.findObjectsInBackground{ (userTracks, error) in
                if error == nil {
                    print(userTracks! as Any)
                    self.tracks = userTracks!
                    self.tableView.reloadData()
                }else{
                    print("Error during request of tracks")
                }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count + 1
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SinglePlaylistInfoTableViewCell", for: indexPath) as! SinglePlaylistInfoTableViewCell
            cell.playlistLabel.text = playlist["namePlaylist"] as? String
            let playlistImg = playlist["playlistImageURL"] as! String
            let url = URL(string: playlistImg)!
            cell.playlistImage.af.setImage(withURL: url)
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SinglePlaylistSongTableViewCell", for: indexPath) as! SinglePlaylistSongTableViewCell
            let currentTrack = tracks[indexPath.row - 1]
            cell.songDurationLabel.text = "04:44"
            cell.songTitleLabel.text = currentTrack["trackName"] as? String
            let trackImageURL = currentTrack["trackPosterURL"] as! String
            let url = URL(string: trackImageURL)!
            cell.AlbumImage.af.setImage(withURL: url)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 300
        } else{
            let navigationBarHeight = self.navigationController!.navigationBar.frame.height
            let tabBarheight = self.tabBarController!.tabBar.frame.height
            let height = (view.frame.size.height - (navigationBarHeight*2) - tabBarheight) / 8
            return height
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
