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
    
    // when chaning song slider action
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
            //print("inside played constraint with \(holder.subviews.count)")
        } else if player!.timeControlStatus == .paused{
            player?.play()
            playPauseBtn.setBackgroundImage(UIImage(systemName: "pause"), for: .normal)
            //holder.addSubview(playPauseBtn)
            //print("inside paused constraint with \(holder.subviews.count)")
        }
    }
    
    @IBAction func pressforwardButton(_ sender: Any) {
        guard let duration  = player?.currentItem?.asset.duration else{
                return
            }
        let playerCurrentTime = CMTimeGetSeconds((player?.currentTime())!)
            let newTime = playerCurrentTime + Float64(5)

            if newTime < CMTimeGetSeconds(duration) {

                let time2: CMTime = CMTimeMake(value: Int64(newTime * 1000 as Float64), timescale: 1000)
                player?.seek(to: time2)
            } else if newTime >= CMTimeGetSeconds(duration){
                player?.seek(to: duration)
            }

    }
    
    @IBAction func pressBackwardButton(_ sender: Any) {
        let playerCurrentTime = CMTimeGetSeconds((player?.currentTime())!)
            var newTime = playerCurrentTime - Float64(5)

            if newTime < 0 {
                newTime = 0
            }
        let time2: CMTime = CMTimeMake(value: Int64(newTime * 1000 as Float64), timescale: 1000)
            player?.seek(to: time2)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        songSlider.value = 0.0
        songTitleLabel.text = track
        
       // let url = URL(string: imageURL)!
        //albumImage.af.setImage(withURL: url)
        
        //artistnameLabel.text = artistName
        //configure()// Do any additional setup after loading the view.
    }
    
    
    func configure(){
        
        
        let url = URL(string: previewTrackURL)
                let playerItem:AVPlayerItem = AVPlayerItem(url: url!)
                player = AVPlayer(playerItem: playerItem)
        
        NotificationCenter.default.addObserver(self, selector: #selector(songDidEnd), name:
        NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)

        player!.play()
        
        
        let interval = CMTime(value: 1, timescale: 2)
        player?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { [self](progressTime) in
            let seconds = CMTimeGetSeconds(progressTime)
            //if (player.didfin)
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
    
    @objc func songDidEnd(notification: NSNotification) {
        let seekTime = CMTime(value: Int64(0), timescale: 1)
        player?.seek(to: seekTime)
        playPauseBtn.setBackgroundImage(UIImage(systemName: "play"), for: .normal)
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
    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)

        if parent == nil {
            // The view is being removed from the stack, so call your function here
            NotificationCenter.default.removeObserver(self)
            print("Back button pressed")
        }
    }

    
}
