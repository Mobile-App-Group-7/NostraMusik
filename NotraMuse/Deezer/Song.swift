import Foundation
import SwiftAudioPlayer

class Song {
    private let id: Int
    private let title: String
    private let songRemoteUrl: URL
    private var songLocalUrl: URL?
    
    // Data that may or not be present depending on which enpoint was hit
    private var artist: Artist?
    private var album: Album?
    private let duration: String?
    private let rank: Int?
    
    private enum SongErrors: Error {
        case JsonParseError(String)
    }
    
    init(id: Int, title: String, songLink: String) {
        self.id = id
        self.title = title
        self.songRemoteUrl = URL(string: songLink)!
        self.duration = nil
        self.rank = nil
    }
    
    init(json: [String:Any]) throws {
        guard let id = json["id"] as? Int else {
            throw SongErrors.JsonParseError("unable to find song id")
        }
        
        guard let title = json["title"] as? String else {
            throw SongErrors.JsonParseError("unable to find title")
        }
        
        guard let songLink = json["preview"] as? String else {
            throw SongErrors.JsonParseError("could not find song link")
        }
        
        let album = json["album"]
        let artist = json["artist"]
        
        if album != nil {
            self.album = try Album(json: album as! [String : Any])
        }
        
        if artist != nil {
            self.artist = try Artist(json: artist as! [String : Any])
        }
        
        if let trackDuration = json["duration"] as? Int {
            let minutes = Int(exactly: trackDuration)! / 60 % 60
            let seconds = Int(exactly: trackDuration)! % 60
            let strDuration = String(format:"%02d:%02d", minutes, seconds)
            self.duration = strDuration
        }
        else {
            self.duration = nil
        }
        
        if let rank = json["rank"] as? Int {
            self.rank = rank
        }
        else {
            self.rank = nil
        }
        
        self.id = id
        self.title = title
        self.songRemoteUrl = URL(string: songLink)!
        self.songLocalUrl = nil
        
        if let localUrl = SAPlayer.Downloader.getSavedUrl(forRemoteUrl: self.songRemoteUrl) {
            print("Cached song: \(self.title)")
            self.songLocalUrl = localUrl
        }
    }
    
    public func getId() -> Int {
        return self.id
    }
    
    public func getRemoteUrl() -> URL {
        return self.songRemoteUrl
    }
    
    public func getTitle() -> String {
        return self.title
    }
    
    public func getSongImageUrl() -> URL? {
        if self.album != nil {
            return self.album?.getCoverImageUrl()
        }
        
        if self.artist != nil {
            return self.artist?.getProfilePictureUrl()
        }
        
        return nil
    }
    
    public func getSongDuration() -> String? {
        return self.duration
    }
    
    public func getArtistName() -> String? {
        return self.artist?.getName()
    }
    
    public func getAlbumName() -> String? {
        return self.album?.getTitle()
    }
    
    public func getRank() -> Int? {
        return self.rank
    }
    
    public func downloadSong() {
        SAPlayer.Downloader.downloadAudio(withRemoteUrl: self.songRemoteUrl) { savedUrl, error in
            if (error != nil) {
                print("Error downloading song: \(self.title), Error: \(String(describing: error))")
            }
            else {
                self.songLocalUrl = savedUrl
            }
        }
    }
}
