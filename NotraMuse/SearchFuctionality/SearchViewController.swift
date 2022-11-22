//
//  SearchViewController.swift
//  NotraMuse
//
//  Created by Nelly Delgado Planche on 11/19/22.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource,UITableViewDelegate,UISearchResultsUpdating {
    
    
    
    @IBOutlet weak var tableview: UITableView!
    
    let data = ["Flawless", "Knee Scocks", "Anti-Hero", "Yellow",
                "Dark Red", "CUFF IT", "Shirt", "The Astronaut",
                "Nxde", "Heather", "Whiskey on You",
                "Heart like a truck", "DON'T SAY NOTHING", "Prety Girls Walk", "Bikini Bottom",
                "Unholy", "About You", "Motion Sickness", "Double Denim","angleeyes", "titi te pregunto", "calm down", "ojitos lindos", "la bachata", "despecha","todo de ti", "una vaina loca", "avispas","manana te felicito", "i'm Good","Made you look", "Lift me up", "Tukoh Taka","poker Face", "Daydream" ]
    
    var filteredData: [String]!
    
    var searchController: UISearchController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableview.dataSource = self
        tableview.delegate = self
        
        filteredData = data
        
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
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell") as! SearchTableViewCell
                 
        cell.songLabel?.text = filteredData[indexPath.row]
        return cell
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filteredData = searchText.isEmpty ? data : data.filter({(dataString: String) -> Bool in
                return dataString.range(of:searchText, options: .caseInsensitive) != nil
            })
            
            tableview.reloadData()
        }    /*
              // MARK: - Navigation
              
              // In a storyboard-based application, you will often want to do a little preparation before navigation
              override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
              // Get the new view controller using segue.destination.
              // Pass the selected object to the new view controller.
              }
              */
        
    }}
