//
//  PlaylistViewController.swift
//  NotraMuse
//
//  Created by Nelson  on 11/22/22.
//

import UIKit
import Parse
import AlamofireImage

class PlaylistViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    
    var playlists = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    //show user playlist
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "PlaylistServer")
        // Sorts the results in ascending order by the 'likes' field
        query.whereKey("userID", equalTo: PFUser.current()!);
        
        query.findObjectsInBackground{ (userPlaylists, error) in
                if error == nil {
                    print(userPlaylists! as Any)
                    self.playlists = userPlaylists!
                    self.tableView.reloadData()
                }else{
                    print("Error during request ")
                }
            }
    }
    
    @IBAction func userOnLogOut(_ sender: Any) {
        PFUser.logOut()
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else {return}
        delegate.window?.rootViewController = loginViewController
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlists.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaylistsTableViewCell") as! PlaylistsTableViewCell
        let currentPlaylist = playlists[indexPath.row]
        
        let creatorName = currentPlaylist["creatorName"] as! String
        let playlistImageURL = currentPlaylist["playlistImageURL"] as! String
        let nameOfPlaylist = currentPlaylist["namePlaylist"] as! String
        
        let url = URL(string: playlistImageURL)!
        
        cell.playlistName.text = "Playlist: \(nameOfPlaylist)"
        cell.playlistImage.af.setImage(withURL: url)
        
        return cell
        
    }
    
/*
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showPlaylist", sender: self)
    }
*/
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        print("Loading up the details screen")
        let cell = sender as! UITableViewCell //this sender is the table cell
        let indexPath = tableView.indexPath(for: cell)! //table view knows the table path clicked
        let playlist = playlists[indexPath.row]
        //pass the selected movie to the movie details controller, we need to specify it where we are sending this, name of the variable being assigned to
        let detailsViewController = segue.destination as! SinglePlaylistViewController
        
        detailsViewController.playlist = playlist
        
        //after selecting a movie, and moving to detail tab deselected the action
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
