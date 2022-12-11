//
//  SearchViewController.swift
//  NotraMuse
//
//  Created by Nelly Delgado Planche on 11/19/22.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource,UITableViewDelegate,UISearchResultsUpdating, CellDelegate {
    
    @IBOutlet weak var tableview: UITableView!
    
    var songs = [Song]()
    var artists = [Artist]()
    var albums = [Album]()
    var selectedIndex: Int?
    var searchController: UISearchController!
    
    var trackName: String?
    var trackImage: String?
    var trackArtist: String?
    var trackPreview: String?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableview.dataSource = self
        tableview.delegate = self
                
        // Initializing with searchResultsController set to nil means that
        // searchController will use this view controller to display the search results
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        
        // If we are using this same view controller to present the results
        // dimming it out wouldn't make sense. Should probably only set
        // this to yes if using another controller to display the search results.
        searchController.dimsBackgroundDuringPresentation = false
        
        searchController.searchBar.sizeToFit()
        searchController.searchBar.backgroundColor = UIColor.black
        searchController.searchBar.barTintColor = UIColor.black
//        searchController.searchBar.tintColor = UIColor.white
        tableview.tableHeaderView = searchController.searchBar
        
        // Sets this view controller as presenting view controller for the search interface
        definesPresentationContext = true
        
        
        //editing the search bar COLORS
        searchController.searchBar.tintColor = UIColor.white
        //searchController.searchBar.barTintColor = UIColor.
        //searchController.searchBar.backgroundColor = UIColor.black
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count + albums.count + artists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < songs.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell") as! SearchTableViewCell
            cell.delegate = self
            cell.coverView.af.setImage(withURL: songs[indexPath.row].getSongImageUrl()!)
            cell.songLabel?.text = songs[indexPath.row].getTitle()
            cell.authorLabel.text = "Song \u{2022} \(String(describing: songs[indexPath.row].getArtistName() ?? ""))"
            cell.track = songs[indexPath.row]
            return cell
        }
        else if indexPath.row < albums.count + songs.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchAlbumViewCell") as! SearchAlbumViewCell
            let album = albums[indexPath.row - songs.count]
            cell.album = album
            cell.albumImage.af.setImage(withURL: album.getCoverImageUrl()!)
            cell.albumNameLabel.text = album.getTitle()
            cell.authorLabel.text = "Album \u{2022} \(album.getArtists()!.getName())"
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchArtistViewCell") as! SearchArtistViewCell
            let artist = artists[indexPath.row - albums.count - songs.count]
            cell.artist = artist
            cell.artistImage.af.setImage(withURL: artist.getProfilePictureUrl()!)
            cell.artistName.text = artist.getName()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        
        if indexPath.row < songs.count {
            self.performSegue(withIdentifier: "searchtotrack", sender: nil)
        }
        else if indexPath.row < songs.count + albums.count {
            self.performSegue(withIdentifier: "searchToAlbum", sender: nil)
        }
        else {
            self.performSegue(withIdentifier: "searchToArtist", sender: nil)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchtotrack" {
            let view = segue.destination as! TrackViewController
            let selectedSong = self.songs[self.selectedIndex!]
            view.track = selectedSong
        }
        else if segue.identifier == "playSongVC"{
            let PVC = segue.destination as! PlayerViewController
            PVC.track = trackName!
            PVC.imageURL = trackImage!
            PVC.artistName = trackArtist!
            PVC.previewTrackURL = trackPreview!
        }
        else if segue.identifier == "searchToAlbum" {
            let view = segue.destination as! FullAlbumViewController
            view.album = self.albums[self.selectedIndex! - songs.count]
        }
        else if segue.identifier == "searchToArtist" {
            let view = segue.destination as! ArtistViewController
            view.artist = self.artists[self.selectedIndex! - songs.count - albums.count]
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        searchController.searchBar.searchTextField.textColor = UIColor.white
        if let searchText = searchController.searchBar.text {
            if searchText.isEmpty {
                return
            }
            
            Task {
                //searchText.textColor = UIColor.white
                let (songs, error) = await Deezer.shared.searchSongs(searchTerm: searchText)
                
                if error == nil {
                    self.songs = songs!
                    tableview.reloadData()
                }
                else {
                    print("Error searching songs: \(String(describing: error))")
                }
            }
            
            Task {
                let (albums, error) = await Deezer.shared.searchAlbums(searchTerm: searchText)
                
                if error == nil {
                    self.albums = albums!
                    tableview.reloadData()
                }
                else {
                    print("Error searching albums: \(String(describing: error))")
                }
            }
            
            Task {
                let (artists, error) = await Deezer.shared.searchArtists(searchTerm: searchText)
                
                if error == nil {
                    self.artists = artists!
                    tableview.reloadData()
                }
                else {
                    print("Error searching artist: \(String(describing: error))")
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    
    func playSong(Track: Song!) {
        trackName = Track.getTitle()
        trackImage = Track.getSongImageUrl()!.absoluteString
        trackArtist = Track.getArtistName()!
        trackPreview = Track.getRemoteUrl().absoluteString
        performSegue(withIdentifier: "playSongVC", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let navigationBarHeight = self.navigationController!.navigationBar.frame.height
        let tabBarheight = self.tabBarController!.tabBar.frame.height
        let height = (view.frame.size.height - (navigationBarHeight*2) - tabBarheight) / 6
        return height
    }
}
    
        
        /*// MARK: - Navigation
              
        // In a storyboard-based application, you will often want to do a little preparation before navigation
        func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // Get the new view controller using segue.destination.

            
            // Pass the selected object to the new view controller.

        } */
              
        
