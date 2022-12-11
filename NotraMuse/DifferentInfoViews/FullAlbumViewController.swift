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
            cell.AlbumReleaseDate.text = convertDate(dateStr: album?.getReleaseDate())
            cell.ArtistNameLabel.text = album?.getArtists()?.getName()
            if album?.getCoverImageUrl() != nil {
                cell.AlbumImage.af.setImage(withURL: album!.getCoverImageUrl()!)
                cell.ArtistImage.af.setImage(withURL: (album!.getArtists()?.getProfilePictureUrl()!)!)
                cell.ArtistImage.layer.borderWidth = 1
                cell.ArtistImage.layer.borderColor = UIColor.black.cgColor
                cell.ArtistImage.layer.cornerRadius = cell.ArtistImage.frame.size.height/2
                //cell.ArtistImage.clipsToBounds = true
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SonginAlbumTableViewCell", for: indexPath) as! SonginAlbumTableViewCell
            cell.TrackTitleLabel.text = self.album?.getSongs()![indexPath.row - 1].getTitle()
            cell.TrackDurationLabel.text = String((self.album?.getSongs()![indexPath.row - 1].getSongDuration())!)
            cell.AlbumImage.af.setImage(withURL: album!.getCoverImageUrl()!)
            cell.track = album?.getSongs()![indexPath.row - 1]
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 400
        } else{
            let height = (view.frame.size.height - 88) / 8
            return height
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        
        let playerViewController = segue.destination as! PlayerViewController
        
        playerViewController.track = (self.album?.getSongs()![indexPath.row - 1].getTitle())!
        playerViewController.imageURL = album!.getCoverImageUrl()!.absoluteString
        playerViewController.artistName = (album?.getArtists()?.getName())!
        playerViewController.previewTrackURL = (album?.getSongs()![indexPath.row - 1].getRemoteUrl().absoluteString)!
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    
    private func convertDate(dateStr: String?) -> String? {
        guard let date = dateStr else {
            return nil
        }
        
        let parts = date.components(separatedBy: "-")
        let year = parts[0]
        let month = getMonth(parts[1])
        let day = parts[2]
        
        return month + " " + day + " " + year
    }
    
    private func getMonth(_ s: String) -> String {
        switch s {
        case "01":
            return "January"
        case "02":
            return "Febuary"
        case "03":
            return "March"
        case "04":
            return "April"
        case "05":
            return "May"
        case "06":
            return "June"
        case "07":
            return "July"
        case "08":
            return "August"
        case "09":
            return "September"
        case "10":
            return "October"
        case "11":
            return "November"
        case "12":
            return "December"
        default:
            return ""
        }
    }
}
