import Foundation
import SwiftAudioPlayer

class Song {
  private let id: Int
  private let title: String
  private let songRemoteUrl: URL
  private var songLocalUrl: URL?
  
  private enum SongErrors: Error {
    case JsonParseError(String)
  }
  
  init(id: Int, title: String, songLink: String) {
    self.id = id
    self.title = title
    self.songRemoteUrl = URL(string: songLink)!
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
