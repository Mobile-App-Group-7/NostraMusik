//
//  SinglePlaylistViewController.swift
//  NotraMuse
//
//  Created by Nelson  on 11/22/22.
//

import UIKit

class SinglePlaylistViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 10
        }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SinglePlaylistInfoTableViewCell", for: indexPath) as! SinglePlaylistInfoTableViewCell
            cell.playlistLabel.text = "Playlist Name"
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SinglePlaylistSongTableViewCell", for: indexPath) as! SinglePlaylistSongTableViewCell
            cell.songDurationLabel.text = "04:44"
            cell.songTitleLabel.text = "Playlist song added"
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
