//
//  FullAlbumViewController.swift
//  NotraMuse
//
//  Created by Nelson  on 11/21/22.
//

import UIKit

class FullAlbumViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var album: Album?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        // need to fetch album because the chart data does not contain the data needed
        Task {
            let (album, error) = await Deezer.shared.fetchAlbum(albumId: String(album!.getId()))
            if error != nil {
                print("Unable to get data from deezer api: \(String(describing: error))")
            }
            else {
                self.album = album
                tableView.reloadData()
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
extension FullAlbumViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if album?.getSongs() != nil {
            return album!.getSongs()!.count + 1
        }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "FullAlbumTableViewCell", for: indexPath) as! FullAlbumTableViewCell
            cell.AlbumTitleLabel.text = album?.getTitle()
            cell.AlbumReleaseDate.text = "November 21,2022"
            cell.ArtistNameLabel.text = album?.getArtists()?.getName()
            if album?.getCoverImageUrl() != nil {
                cell.AlbumImage.af.setImage(withURL: (album!.getArtists()?.getProfilePictureUrl()!)!)
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SonginAlbumTableViewCell", for: indexPath) as! SonginAlbumTableViewCell
            cell.TrackTitleLabel.text = self.album?.getSongs()![indexPath.row - 1].getTitle()
            cell.TrackDurationLabel.text = String((self.album?.getSongs()![indexPath.row - 1].getSongDuration())!)
            cell.AlbumImage.af.setImage(withURL: album!.getCoverImageUrl()!)
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
