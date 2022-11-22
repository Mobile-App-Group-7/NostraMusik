//
//  FullAlbumViewController.swift
//  NotraMuse
//
//  Created by Nelson  on 11/21/22.
//

import UIKit

class FullAlbumViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
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
extension FullAlbumViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "FullAlbumTableViewCell", for: indexPath) as! FullAlbumTableViewCell
            cell.AlbumTitleLabel.text = "Album"
            cell.AlbumReleaseDate.text = "November 21,2022"
            cell.ArtistNameLabel.text = "Artist"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SonginAlbumTableViewCell", for: indexPath) as! SonginAlbumTableViewCell
            cell.TrackTitleLabel.text = "Song Name Here"
            cell.TrackDurationLabel.text = "02:10"
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 352
        } else{
            let navigationBarHeight = self.navigationController!.navigationBar.frame.height
            let tabBarheight = self.tabBarController!.tabBar.frame.height
            let height = (view.frame.size.height - (navigationBarHeight*2) - tabBarheight) / 8
            return height
        }
        
    }
}
