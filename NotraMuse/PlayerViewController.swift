//
//  PlayerViewController.swift
//  NotraMuse
//
//  Created by Nelson  on 11/28/22.
//

import UIKit
import AVFoundation
import AlamofireImage

class PlayerViewController: UIViewController {

    var track: String = ""
    var imageURL: String = ""
    var artistName: String = ""
    var previewTrackURL: String = ""
    
    
    var player: AVPlayer?
    var playerItem: AVPlayerItem?
    
    @IBOutlet weak var holder: UIView!
    @IBOutlet weak var songTitleLabel: UILabel!
    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var artistnameLabel: UILabel!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var songDurationLabel: UILabel!
    @IBOutlet weak var playPauseBtn: UIButton!
    @IBOutlet weak var forwardBtn: UIButton!
    @IBOutlet weak var backwardBtn: UIButton!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var songSlider: UISlider!
    
    @IBAction func changeAudioTime(_ sender: Any) {
        print(songSlider.value)
        
        if let duration = player?.currentItem?.asset.duration{
            let totalSeconds = CMTimeGetSeconds(duration)
            let value = Float64(songSlider.value) * totalSeconds
            
            let seekTime = CMTime(value: Int64(value), timescale: 1)
            
            player?.seek(to: seekTime)
            
        }
    }
    
    @IBAction func pressPlayPauseButton(_ sender: Any) {
        if player!.timeControlStatus == .playing{
            player?.pause()
            playPauseBtn.setBackgroundImage(UIImage(systemName: "play"), for: .normal)
            //holder.addSubview(playPauseBtn)
            print("inside played constraint with \(holder.subviews.count)")
        } else if player!.timeControlStatus == .paused{
            player?.play()
            playPauseBtn.setBackgroundImage(UIImage(systemName: "pause"), for: .normal)
            //holder.addSubview(playPauseBtn)
            print("inside paused constraint with \(holder.subviews.count)")
        }
    }
    
    @IBAction func pressforwardButton(_ sender: Any) {
    }
    
    @IBAction func pressBackwardButton(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        songTitleLabel.text = track
        
        let url = URL(string: imageURL)!
        albumImage.af.setImage(withURL: url)
        
        //)(UIImage(systemName: "person.fill"))
        artistnameLabel.text = artistName
        configure()// Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    /*override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("inside view did layout submvies")
        if holder.subviews.count == 7 {
            configure()
        }
    }*/
    
    func configure(){
        
        
        let url = URL(string: previewTrackURL)
                let playerItem:AVPlayerItem = AVPlayerItem(url: url!)
                player = AVPlayer(playerItem: playerItem)
        player!.play()
        
        let interval = CMTime(value: 1, timescale: 2)
        player?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { [self](progressTime) in
            let seconds = CMTimeGetSeconds(progressTime)
            let secondsString = String(format: "%02d", Int(seconds.truncatingRemainder(dividingBy: 60)))
            let minutesString = String(format: "%02d", Int(seconds / 60))
            self.currentTimeLabel.text = "\(minutesString):\(secondsString)"
            
            if let duration = self.player?.currentItem?.asset.duration{
                let durationSeconds = CMTimeGetSeconds(duration)
                
                songSlider.value = Float(seconds / durationSeconds)
            }

        })
        
        player?.volume = 0.3
        
        playPauseBtn.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
        playPauseBtn.tintColor = UIColor(red: 200/255, green: 115/255,blue: 200/255, alpha: 1)
        backwardBtn.tintColor = UIColor(red: 200/255, green: 115/255,blue: 200/255, alpha: 1)
        forwardBtn.tintColor = UIColor(red: 200/255, green: 115/255,blue: 200/255, alpha: 1)
        //holder.addSubview(playPauseBtn)
        
        //slider.frame = CGRect(x: 20, y: holder.frame.size.height-100, width: holder.frame.size.width-40, height: 50)
        
        slider.value = 0.3
        slider.addTarget(self, action: #selector(didSlideSlider(_:)), for: .valueChanged)
       // holder.addSubview(slider)
        
        if let duration = player?.currentItem?.asset.duration{
            let seconds = CMTimeGetSeconds(duration)
            
            //print("Duration: \(duration)")
            //print("seconds: \(seconds)")
            let secondsText = Int(seconds.truncatingRemainder(dividingBy: 60))
            
            let minutesText = String(format: "%02d", Int(seconds) / 60)
            songDurationLabel.text = "\(minutesText):\(secondsText)"
        }
        
    }
    
    @objc func didSlideSlider(_ slider: UISlider){
        let value = slider.value
        player?.volume = value
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if let player = player {
            player.pause()
            playPauseBtn.setBackgroundImage(UIImage(systemName: "play"), for: .normal)

        }
    }

    
}
