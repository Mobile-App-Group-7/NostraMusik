//
//  HomeViewController.swift
//  NotraMuse
//
//  Created by Nelson  on 11/14/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBAction func ClickingHomeUnit(_ sender: UIButton) {
        //self.performSegue(withIdentifier: "MoveToAlbumView", sender: self)
        
    }
    
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
extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeSongsTableCell", for: indexPath) as! HomeSongTableViewCell
            cell.RowLabel.text = "Top Songs"
            cell.indexPathVar = indexPath.row
            return cell
        } else if indexPath.row == 1{
            let cell =  tableView.dequeueReusableCell(withIdentifier: "HomeSongsTableCell", for: indexPath) as! HomeSongTableViewCell
            cell.RowLabel.text = "Top Albums"
            cell.indexPathVar = indexPath.row
            return cell
        } else{
            let cell =  tableView.dequeueReusableCell(withIdentifier: "HomeSongsTableCell", for: indexPath) as! HomeSongTableViewCell
            cell.RowLabel.text = "Top Artists"
            cell.indexPathVar = indexPath.row
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let navigationBarHeight = self.navigationController!.navigationBar.frame.height
        let tabBarheight = self.tabBarController!.tabBar.frame.height
        let height = (view.frame.size.height - (navigationBarHeight*2) - tabBarheight) / 3
        return height
    }
    
}
