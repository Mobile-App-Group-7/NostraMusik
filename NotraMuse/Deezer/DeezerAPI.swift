import Foundation

class Deezer {
    
    private enum DeezerApiErrors: Error {
        case Non200Error(String)
        case UnreachableCode(String)
        case ErrorResponse(String)
    }
    
    private init() {}
    
    static public let shared = Deezer()
    
    static private let BASE_URL = "https://api.deezer.com"
    
    static private let HOST = "api.deezer.com"
    
    func fetchAlbum(albumId: String) async -> (Album?, Error?) {
        do {
            let url = URL(string: Deezer.BASE_URL + "/album/\(albumId)")!
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                return (nil, DeezerApiErrors.Non200Error("Unexpected response: \(String(describing: response))"))
            }
            
            let json = try JSONSerialization.jsonObject(with: data) as! [String:Any]
            
            if let error = json["error"] {
                return (nil, DeezerApiErrors.ErrorResponse("Error response from deezer api: \(error)"))
            }
            
            let album = try Album(json: json)
            
            return (album, nil)
        }
        catch {
            return (nil, error)
        }
    }
    
    func fetchArtist(artistId: String) async -> (Artist?, Error?) {
        do {
            let url = URL(string: Deezer.BASE_URL + "/artist/\(artistId)")!
            
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                return (nil, DeezerApiErrors.Non200Error("Unexpected response: \(String(describing: response))"))
            }
            
            let json = try JSONSerialization.jsonObject(with: data) as! [String:Any]
            
            if let error = json["error"] {
                return (nil, DeezerApiErrors.ErrorResponse("Error response from deezer api: \(error)"))
            }
            
            let artist = try Artist(json: json)
            
            return (artist, nil)
        }
        catch {
            return (nil, error)
        }
    }
    
    func fetchSong(songId: String) async -> (Song?, Error?) {
        do {
            let url = URL(string: Deezer.BASE_URL + "/track/\(songId)")!
            
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                return (nil, DeezerApiErrors.Non200Error("Unexpected response: \(String(describing: response))"))
            }
            
            let json = try JSONSerialization.jsonObject(with: data) as! [String:Any]
            
            if let error = json["error"] {
                return (nil, DeezerApiErrors.ErrorResponse("Error response from deezer api: \(error)"))
            }
            
            let song = try Song(json: json)
            
            return (song, nil)
        }
        catch {
            return (nil, error)
        }
    }
    
    func searchAlbums(searchTerm: String) async -> ([Album]?, Error?) {
        do {
            var urlComponent = URLComponents()
            urlComponent.scheme = "https"
            urlComponent.host = Deezer.HOST
            urlComponent.path = "/search/album"
            urlComponent.queryItems = [
                URLQueryItem(name: "q", value: searchTerm)
            ]
            
            let url = urlComponent.url!
            
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                return (nil, DeezerApiErrors.Non200Error("Unexpected response: \(String(describing: response))"))
            }
            
            let dataJson = try JSONSerialization.jsonObject(with: data) as! [String:Any]
            
            if let error = dataJson["error"] {
                return (nil, DeezerApiErrors.ErrorResponse("Error response from deezer api: \(error)"))
            }
            
            let albumsJson = dataJson["data"] as! [[String:Any]]
            var albums = [Album]()
            
            for albumJson in albumsJson {
                let album = try Album(json: albumJson)
                albums.append(album)
            }
            
            return (albums, nil)
        }
        catch {
            return (nil, error)
        }
    }
    
    func searchArtists(searchTerm: String) async -> ([Artist]?, Error?) {
        do {
            var urlComponent = URLComponents()
            urlComponent.scheme = "https"
            urlComponent.host = Deezer.HOST
            urlComponent.path = "/search/artist"
            urlComponent.queryItems = [
              URLQueryItem(name: "q", value: searchTerm)
            ]
            
            let url = urlComponent.url!
            
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                return (nil, DeezerApiErrors.Non200Error("Unexpected response: \(String(describing: response))"))
            }
            
            let dataJson = try JSONSerialization.jsonObject(with: data) as! [String:Any]
            
            if let error = dataJson["error"] {
                return (nil, DeezerApiErrors.ErrorResponse("Error response from deezer api: \(error)"))
            }
            
            let artistsJson = dataJson["data"] as! [[String:Any]]
            var artists = [Artist]()
            
            for artistJson in artistsJson {
                let artist = try Artist(json: artistJson)
                artists.append(artist)
            }
            
            return (artists, nil)
        }
        catch {
            return (nil, error)
        }
    }
    
    func searchSongs(searchTerm: String) async -> ([Song]?, Error?) {
        do {
            var urlComponent = URLComponents()
            urlComponent.scheme = "https"
            urlComponent.host = Deezer.HOST
            urlComponent.path = "/search/track"
            urlComponent.queryItems = [
              URLQueryItem(name: "q", value: searchTerm)
            ]
            
            let url = urlComponent.url!
            
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                return (nil, DeezerApiErrors.Non200Error("Unexpected response: \(String(describing: response))"))
            }
            
            var songs = [Song]()
            let dataJson = try JSONSerialization.jsonObject(with: data) as! [String:Any]
            
            if let error = dataJson["error"] {
                return (nil, DeezerApiErrors.ErrorResponse("Error response from deezer api: \(error)"))
            }
            
            let songsJson = dataJson["data"] as! [[String:Any]]
            
            for songJson in songsJson {
                let song = try Song(json: songJson)
                songs.append(song)
            }
            
            return (songs, nil)
        }
        catch {
            return (nil, error)
        }
    }
    
    
    func fetchChart() async -> (ChartResult?, Error?) {
        do {
            let url = URL(string: Deezer.BASE_URL + "/chart")!
            
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                return (nil, DeezerApiErrors.Non200Error("Unexpected response: \(String(describing: response))"))
            }
            
            let json = try JSONSerialization.jsonObject(with: data) as! [String:Any]
            
            if let error = json["error"] {
                return (nil, DeezerApiErrors.ErrorResponse("Error response from deezer api: \(error)"))
            }
            
            let chartResult = try ChartResult(json: json)
            
            return (chartResult, nil)
        }
        catch {
            return (nil, error)
        }
    }
}
