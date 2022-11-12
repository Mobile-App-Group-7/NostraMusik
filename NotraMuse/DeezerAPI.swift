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
  
  func searchSongs(searchTerm: String) async -> ([Song]?, Error?) {
    do {
      let queryItems = [URLQueryItem(name: "q", value: searchTerm)]
      var url = URL(string: Deezer.BASE_URL + "/search/track")!
      url.append(queryItems: queryItems)
      
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
