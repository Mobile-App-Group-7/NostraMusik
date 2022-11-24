import Foundation

class ChartResult {
    private var songs = [Song]()
    private var artists = [Artist]()
    private var albums = [Album]()
    
    init(json: [String:Any]) throws {
        let songsData = json["tracks"] as! [String:Any]
        let songs = songsData["data"] as! [[String:Any]]
        
        for song in songs {
            self.songs.append(try Song(json: song))
        }
        
        let artistData = json["artists"] as! [String:Any]
        let artists = artistData["data"] as! [[String:Any]]
        
        for artist in artists {
            self.artists.append(try Artist(json: artist))
        }
        
        let albumData = json["albums"] as! [String:Any]
        let albums = albumData["data"] as! [[String:Any]]
        
        for album in albums {
            self.albums.append(try Album(json: album))
        }
    }
    
    public func getSongs() -> [Song] {
        return self.songs
    }
    
    public func getArtists() -> [Artist] {
        return self.artists
    }
    
    public func getAlbums() -> [Album] {
        return self.albums
    }
}
