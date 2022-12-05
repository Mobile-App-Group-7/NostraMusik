//
//  SearchViewController.swift
//  NotraMuse
//
//  Created by Nelly Delgado Planche on 11/19/22.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource,UITableViewDelegate,UISearchResultsUpdating, CellDelegate {
    func playSong() {
        //performSegue(withIdentifier: "playSongVC", sender: nil)
        print("Moving to music player VC")
    }
    
    
    
    
    @IBOutlet weak var tableview: UITableView!
    
    var searchResult = [Song]()
    var selectedIndex: Int?
    var searchController: UISearchController!
    
    
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
        tableview.tableHeaderView = searchController.searchBar
        
        // Sets this view controller as presenting view controller for the search interface
        definesPresentationContext = true
        
        
        //editing the search bar COLORS
        searchController.searchBar.tintColor = UIColor.systemPurple
        //searchController.searchBar.barTintColor = UIColor.
        searchController.searchBar.backgroundColor = UIColor.black
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell") as! SearchTableViewCell
        cell.delegate = self
        cell.coverView.af.setImage(withURL: searchResult[indexPath.row].getSongImageUrl()!)
        cell.songLabel?.text = searchResult[indexPath.row].getTitle()
        cell.authorLabel.text = searchResult[indexPath.row].getArtistName()
        cell.track = searchResult[indexPath.row]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        self.performSegue(withIdentifier: "searchtotrack", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchtotrack" {
            let view = segue.destination as! TrackViewController
            let selectedSong = self.searchResult[self.selectedIndex!]
            view.track = selectedSong
        } else if segue.identifier == "playSongVC"{
            print("Setting up cell")
            

        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            Task {
                let (songs, error) = await Deezer.shared.searchSongs(searchTerm: searchText)
                
                if error == nil {
                    self.searchResult = songs!
                }
                else {
                    print("Error searching for songs: \(String(describing: error))")
                }
                
                tableview.reloadData()
            }
        }
    }}
        
        /*// MARK: - Navigation
              
        // In a storyboard-based application, you will often want to do a little preparation before navigation
        func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // Get the new view controller using segue.destination.

            
            // Pass the selected object to the new view controller.

        } */
              
        
