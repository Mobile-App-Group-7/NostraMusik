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
        
        if album?.getSongs() == nil {
            Task {
                let (newAlbum, error) = await Deezer.shared.fetchAlbum(albumId: "\(album!.getId())")
                
                if error == nil {
                    self.album = newAlbum
                    self.tableView.reloadData()
                }
                else {
                    print("Error fetching song \(String(describing: error))")
                }
            }
        }
        
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
        if album == nil || album?.getSongs() == nil {
            return 10
        }
        
        return (album!.getSongs()!.count) + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "FullAlbumTableViewCell", for: indexPath) as! FullAlbumTableViewCell
            cell.AlbumTitleLabel.text = album?.getTitle()
            cell.AlbumReleaseDate.text = "November 21,2022"
            cell.ArtistNameLabel.text = "Artist"
            cell.AlbumImage.af.setImage(withURL: album!.getCoverImageUrl()!)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SonginAlbumTableViewCell", for: indexPath) as! SonginAlbumTableViewCell
            if album?.getSongs() == nil {
                return cell
            }
            cell.TrackTitleLabel.text = album!.getSongs()![indexPath.row-1].getTitle()
            cell.TrackDurationLabel.text = "02:10"
            cell.AlbumImage.af.setImage(withURL: album!.getCoverImageUrl()!)
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 352
        } else{
            if (self.navigationController == nil) {
                return 100
            }
            
            let navigationBarHeight = self.navigationController!.navigationBar.frame.height
            let tabBarheight = self.tabBarController!.tabBar.frame.height
            let height = (view.frame.size.height - (navigationBarHeight*2) - tabBarheight) / 8
            return height
        }
        
    }
}
