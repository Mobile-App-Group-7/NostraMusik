import Foundation
import AlamofireImage
import SwiftAudioPlayer

class Album {
    private let id: Int
    private let title: String
    private let coverImageUrl: URL?
    private var songs: [Song]?
    
    private let artist: Artist?
    private let releaseDate: String?
    
    private enum AlbumErrors: Error {
        case JsonParseError(String)
    }
    
    init(id: Int, title: String, coverImageUrl: URL) {
        self.id = id
        self.title = title
        self.coverImageUrl = coverImageUrl
        self.songs = nil
        self.artist = nil
        self.releaseDate = nil
    }
    
    init(json: [String:Any]) throws {
        guard let id = json["id"] as? Int else {
            throw AlbumErrors.JsonParseError("unable to find id")
        }
        
        guard let title = json["title"] as? String else {
            throw AlbumErrors.JsonParseError("unable to find title")
        }
        
        guard let coverImageUrl = json["cover_xl"] as? String else {
            throw AlbumErrors.JsonParseError("unable to find cover image url")
        }
        
        if let aristsJson = json["artist"] {
            self.artist = try Artist(json: aristsJson as! [String: Any])
        }
        else {
            self.artist = nil
        }
        
        if let releaseDate = json["release_date"] {
            self.releaseDate = releaseDate as? String
        }
        else {
            self.releaseDate = nil
        }
        
        self.songs = nil
        
        let data = json["tracks"] as? [String:Any]
        if data != nil {
            guard let songsJson = data!["data"] as? [[String:Any]] else {
                throw AlbumErrors.JsonParseError("unable to parse songs")
            }
            
            self.songs = []
            
            for song in songsJson {
                self.songs?.append(try Song(json: song))
            }
        }
        
        self.id = id
        self.title = title
        self.coverImageUrl = URL(string: coverImageUrl)
    }
    
    public func getSongs() -> [Song]? {
        return self.songs
    }
    
    public func getCoverImageUrl() -> URL? {
        return self.coverImageUrl
    }
    
    public func getTitle() -> String {
        return self.title
    }
    
    public func getId() -> Int {
        return self.id
    }
    
    public func getArtists() -> Artist? {
        return self.artist
    }
    
    public func getReleaseDate() -> String? {
        return self.releaseDate
    }
}
