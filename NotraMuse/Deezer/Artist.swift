import UIKit
import Foundation
import AlamofireImage

class Artist {
    private let id: Int
    private let name: String
    private let profilePictureUrl: URL
    private let numberFans: Int?
    
    private enum ArtistErrors: Error {
        case JsonParseError(String)
    }
    
    init(id: Int, name: String, profilePictureUrl: URL) {
        self.id = id
        self.name = name
        self.profilePictureUrl = profilePictureUrl
        self.numberFans = nil
    }
    
    init(json: [String:Any]) throws {
        guard let id = json["id"] as? Int else {
            throw ArtistErrors.JsonParseError("unable to find id")
        }
        
        guard let name = json["name"] as? String else {
            throw ArtistErrors.JsonParseError("unable to find name")
        }
        
        guard let profilePictureUrl = json["picture"] as? String else {
            throw ArtistErrors.JsonParseError("unable to find profile image url")
        }
        
        self.id = id
        self.name = name
        self.profilePictureUrl = URL(string: profilePictureUrl)!
        self.numberFans = json["nb_fan"] as? Int
    }
    
    public func getName() -> String {
        return self.name
    }
    
    public func getId() -> Int {
        return self.id
    }
    
    public func getProfilePictureUrl() -> URL {
        return self.profilePictureUrl
    }
    
    public func getNumFans() -> Int? {
        return self.numberFans
    }
}
