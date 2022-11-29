//
//  PlayerViewController.swift
//  NotraMuse
//
//  Created by Nelson  on 11/28/22.
//

import UIKit
import AVFoundation

class PlayerViewController: UIViewController {

    var track: String = ""
    var imageURL: String = ""
    var artistName: String = ""
    
    var player: AVPlayer?
    var playerItem: AVPlayerItem?
    
    @IBOutlet weak var holder: UIView!
    @IBOutlet weak var songTitleLabel: UILabel!
    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var artistnameLabel: UILabel!
    
    @IBOutlet weak var playPauseBtn: UIButton!
    @IBOutlet weak var forwardBtn: UIButton!
    @IBOutlet weak var backwardBtn: UIButton!
    @IBOutlet weak var slider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        songTitleLabel.text = track

        //)(UIImage(systemName: "person.fill"))
        artistnameLabel.text = artistName        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("inside view did layout submvies")
        if holder.subviews.count == 7 {
            configure()
        }
    }
    
    func configure(){
        
        
        let url = URL(string: "https://cdns-preview-8.dzcdn.net/stream/c-828a4c6ef4e912f1459f09791d26f863-4.mp3")
                let playerItem:AVPlayerItem = AVPlayerItem(url: url!)
                player = AVPlayer(playerItem: playerItem)
        player!.play()
        
        
        player?.volume = 0.3
        
        //slider.frame = CGRect(x: 20, y: holder.frame.size.height-100, width: holder.frame.size.width-40, height: 50)
        
        slider.value = 0.3
        slider.addTarget(self, action: #selector(didSlideSlider(_:)), for: .valueChanged)
       // holder.addSubview(slider)
        //let urlString = Bundle.main.path(forResource: "Test", ofType: "mp3")
//        let url =  URL(string: "https://cdns-preview-8.dzcdn.net/stream/c-828a4c6ef4e912f1459f09791d26f863-4.mp3")
//        let urlString = url?.path
//        do {
//            try AVAudioSession.sharedInstance().setMode(.default)
//            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
//
//            print(urlString as Any)
//            if let urlString = urlString {
//                let urlString = "Nothing"
//                print(urlString)
//            } else{
//                print("urlWorks")
//                return
//            }
//            guard let urlString = urlString else {
//                return
//            }
//            player = try AVAudioPlayer(contentsOf: URL(string: urlString)!)
//
//            guard let player = player else {
//                return
//            }
//            player.play()
//
//        }
//        catch{
//            print("error with audio player")
//        }
    }
    
    @objc func didSlideSlider(_ slider: UISlider){
        let value = slider.value
        player?.volume = value
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if let player = player {
            player.pause()
        }
    }

}
