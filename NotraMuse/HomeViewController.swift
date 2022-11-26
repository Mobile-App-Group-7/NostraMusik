//
//  HomeViewController.swift
//  NotraMuse
//
//  Created by Nelson  on 11/14/22.
//

import UIKit
import Parse

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var chart: ChartResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        
        Task {
            let (chartResult, error) = await Deezer.shared.fetchChart()
            
            if error != nil {
                print("Error fetching the chart \(String(describing: error))")
            }
            else {
                self.chart = chartResult
                self.tableView.reloadData()
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeSongsTableCell", for: indexPath) as! HomeSongTableViewCell
            cell.RowTitleLabel.text = "Top Songs"
            cell.indexPathVar = indexPath.row
            cell.parent = self
            cell.chart = self.chart
            return cell
        } else if indexPath.row == 1{
            let cell =  tableView.dequeueReusableCell(withIdentifier: "HomeSongsTableCell", for: indexPath) as! HomeSongTableViewCell
            cell.RowTitleLabel.text = "Top Albums"
            cell.indexPathVar = indexPath.row
            cell.parent = self
            cell.chart = self.chart
            return cell
        } else{
            let cell =  tableView.dequeueReusableCell(withIdentifier: "HomeSongsTableCell", for: indexPath) as! HomeSongTableViewCell
            cell.RowTitleLabel.text = "Top Artists"
            cell.indexPathVar = indexPath.row
            cell.parent = self
            cell.chart = self.chart
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let navigationBarHeight = self.navigationController!.navigationBar.frame.height
        let tabBarheight = self.tabBarController!.tabBar.frame.height
        let height = (view.frame.size.height - (navigationBarHeight*2) - tabBarheight) / 3
        return height
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard sender is HomeSongTableViewCell else {
            return
        }
        
        if segue.identifier == "showSongInfo" {
            
        }
        else if segue.identifier == "showAlbumInfo" {
            let album = (sender as! HomeSongTableViewCell).sendingData as! Album
            (segue.destination as! FullAlbumViewController).album = album
        }
        else if segue.identifier == "showArtistInfo" {
            
        }
    }
}
