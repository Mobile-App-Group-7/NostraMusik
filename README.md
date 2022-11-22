App Design Project - README
===

# NotraMuse - Group 7

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
3. [Schema](#Schema)
4. [Sprint 2](#Sprint-2)
5. [Sprint 1](#Sprint-1)
6. [Authors](#Authors)

## Overview
### Description
Music App, where users can create a personal account to explore/discover tracks, artist and albums top on the area and world wide, at the same time search for tracks listen to their previews, look for artist and albums, and being able to create and edit their own personalized playlist with their selected tracks.

### App Evaluation
- **Category: Music**
- **Mobile: For application being mobile is essential in the sense that we will be dealing user information extraction using their location, for example, top songs or albums in their area or country. Another reason for mobile is the integration of working with a mobile app in the sense of playing previews of songs and easy traversal through multiple songs in a playlist from the user.**
- **Story: Users will be able have an easy access to popular songs and artists around their location, this could help users discover new songs and artists to listen to with simplicity.**
- **Market: With the growing number of people using streaming services to listen to music, listening to music is more than a norm nowadays. This app will be useful for many people in the sense that it will allow users to see songs and artists that they listen to in said streaming services.**
- **Habit: Any individual can make an account with our app. Users who would use this app are users who frequently listen to music. The use of the app would depend on how much users want to explore the music that they prefer to listen to. This app will encourage users to go and explore songs and artists with an endless limit.**
- **Scope: The basic structure of the app at the end that we wish to have seems to be manageable in the sense that will have an app that does the same functionalities like displaying and retreiving information from the music industry. It will be interesting to show this basic structure as we are able to show live data that can be changed from the user or other users. Having this basic structure alone gives us a clear vision of what we want for the app and if the time permits shoot for a more traversel application.**

## Product Spec

### 1. User Stories (Required and Optional)
To kick off this session, we want to list out the things a user can do within our app, and tag them as “must-have” (required) or “nice-to-have” (optional)

**Required Must-have Stories**
For NotraMuse, we identified the following “must-have” features which a user needs to be able to perform for the app to work:

After Sprint 1 most use cases are made in parts and just need to be joined to have the completed user story

* User can login
* User can sign up
* User stays logged in across restarts
* User can explore the top artists, tracks and albums world wide and default location set as the U.S.
* User can search for tracks, albums, and artists
[x] User can see detailed information about a track, artist, album
* User can add searched tracks to personalize playlist
* User can play previews from saved tracks on the playlist
* User can play previews from searched tracks
* User can visualize saved tracks on playlist
* User can visualize own profile user information 

**Optional Nice-to-have Stories**

* User can edit playlist changing playlist name and deleting tracks
* User can create new playlist, maximum 15
* User can add albums to their personal account saved playlist
* User has the ability to traverse over the top artist, tracks and albums on the current location
* User can do customize search for only tracks, only artist and only albums
* User can do combination of filter cutomize search
* User can edit profile name, add description and profile picture

### 2. Screen Archetypes

* Login/Sign Up Screen 
    * User can login
    * User can sign up
    * User stays logged in across restarts
* Profile Screen
    * User can visualize own profile user information
* Stream - Home Screen
    * User can explore of top artist, tracks and albums world wide and default location set as the U.S.
* Search/Stream - Search Screen
    * User can search for tracks, albums and artist
    * User can add searched tracks to personalize playlist
    * User can play previews from searched tracks
* Detail Screen
    * User can see detailed information about a track, artist, album
* Stream - Playlist Screen
    * User can visualize and play previews from saved tracks on the playlist

### 3. Navigation

**Tab Navigation** (Tab to Screen)
* Home Screen
* Playlist Screen
* Profile Screen
* Search Screen

**Flow Navigation** (Screen to Screen)

* Login/Register Screen
   * Home Screen
* Home Screen
   * None, but future version can involve the navigation to a detailed screen for seeing more detail information of the artist, album and track.
* Playlist screen
   * None, but future version can have this screen as stream to display all the playlist saved and will involve navigation to a detailed screen of the playlist with all the tracks saved.
* Search Screen
   * Detail Screen
* Profile Screen
   * None, but future version will likely involve navigation to a detailed screen in which the user can edit profile information.
* Detail Screen
    * Search Screen

## Wireframes
<img src="https://github.com/NPlanche/Mobile-Apps-Projects/blob/main/NotraMuse.png" width=600>

### [BONUS] Digital  Wireframes & Mockups
<img src="https://github.com/NPlanche/Mobile-Apps-Projects/blob/main/NotraMuseWireframe_Digital.png" width=600>


### [BONUS] Interactive Prototype
<img src='http://g.recordit.co/623MjtbyCU.gif' width='' alt='Video Walkthrough' />

## Schema 
### Models
#### User

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | objectId      | String   | unique id for the user post (default field) |
   | username      | String   | Username of the user |
   | image         | String   | Password of the user |
   
#### UserPlaylists
   
   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | objectId      | String   | unique id for the user post (default field) |
   | creator       | Pointer to user | Name of the playlist creator |
   | name          | String   | Name of the playlist |
   | playlist_img  | File     | Cover image of the playlist |
   | songIds       | Array pointers to songs  | An array of ids of songs that are in the playlist |
   
#### Songs

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | objectId      | String   | unique id for the user's playlist (default field) |
   | name          | String   | Name of the song |
   | cover_image   | file     | cover image of the song |
   | album_name    | String   | Name of the album this song belongs to |
   | release       | DateTime | date the song was released (default field) |  
   | track_no      | Number   | track number |

#### UserAlbums (optional)
   
   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | objectId      | String   | unique id for the user's album (default field) |
   | creator       | Pointer to user | Name of the playlist creator |
   | albumID       | Pointer to album| Name of the album |
   | album_img     | File     | Cover image of the album |

   
#### Albums (optional)

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | objectId      | String   | unique id for the user post (default field) |
   | name          | String   | Name of the album | 
   | cover_image   | file     | cover image of the album|
   | artist        | string   | name of the artist|  
   | tracks        | JSON Object| Contains all the tracks in the album|

### Networking
List of network requests by screen:
- Login/Sign Up Screen
    - (Read/GET) Verify user login credentials 

    ```swift
    let username = userField.text!
    let  password = passwordField.text!

    PFUser.logInWithUsername(inBackground: username, password: password) {(user, error) in
    if user != nil{
        self.performSegue(withIdentifier: "loginSegue", sender: nil)
    } else {
        print("Error: \(String(describing: error))")
    }
    ```


    - (Create/POST) Create a new user object
    
    ```swift
    let user = PFUser()
            user.username = userField.text
            user.password = passwordField.text

            user.signUpInBackground{ (success ,error) in
                if success{
                    self.performSegue(withIdentifier: "loginSegue", sender: nil)
    ```
- Home Feed Screen
    - None
- Profile Screen
    - (Read/GET) Query logged in user object
    ```swift
    let query = PFQuery(className:"User")
    query.whereKey("Username", equalTo:"SampleUser")
    query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
        if let error = error {
            // Log details of the failure
            print(error.localizedDescription)
        } else if let objects = objects {
            // The find succeeded.
            print("Successfully retrieved user information.")
            // Do something with the found objects
            user = objects
        }
    }
    ```
- Search Screen
    - (Create/POST) Create a new track object on user playlist
    ```swift
    let track = PFObject(className: "Playlist")
        
        track["user"] = PFUser.current()!
        track["title"] = track_title!
        track["artist"] = artist!
        
        let imageData = uploadImage.image!.pngData()
        let file = PFFileObject(name: "image.png", data: imageData!)
        track["artist_pic"] = file

        track["album"] = album!
        
        track.saveInBackground{  (success, error) in
            usleep(3000)
            if success {
                print("saved!")
            
            } else {
                print("Error!")
            }
        }
    ```
- Playlist Screen
    - (Read/GET) Query all saved tracks where user is author
    ```swift
    let query = PFQuery(className:"Playlist")
    query.whereKey("user", equalTo: currentUser)
    query.order(byDescending: "updatedAt")
    query.findObjectsInBackground { (tracks: [PFObject]?, error: Error?) in
       if let error = error {
          print(error.localizedDescription)
       } else if let tracks = tracks {
          print("Successfully retrieved user's playlist.")
       }
    }
    ```
- Detail Screen
    - None

#### [OPTIONAL:] Existing API Endpoints
##### last.fm API
- Base URL - [https://www.last.fm/api](https://www.last.fm/api)

   HTTP Verb | Endpoint | Description
   ----------|----------|------------
    `GET`    | /tag.getTopTags | get the top global tags like rock, electronic, hip-hop
    `GET`    | /tag.gettopartists&tag= | get all the top artists from a passed tag
    `GET`    | /tag.gettoptracks&tag= | get all the top tracks from a passed tag
    `GET`    | /tag.gettopalbums&tag= | get all the top albums from a passed tag
    `GET`    | /geo.gettoptracks&country= | get all the top tracks from the passed country
    `GET`    | /geo.gettopartists&country= | get all the top artist from the passed country
    

##### Deezer API
- Base URL - [https://api.deezer.com](https://api.deezer.com)

   HTTP Verb | Endpoint | Description
   ----------|----------|------------
    `GET`    | /artist/artist_id | Receive artist info by id
    `GET`    | /artist/artist_id/albums | Get all info on all of artist's albums
    `GET`    | /album/album_id | Get info on a specific album by id
    `GET`    | /album/album_id/tracks | Get info on that specific albums tracks 
    `GET`    | /track/track_id | Get info about that specific track by id 
    `GET`    | /search?q=word | Search query for anything that contains given word
    `GET`    | /chart | Get top artist,tracks, albums, playlist, and podcast 
    
    
## Sprint 2

## Nelson Mendez

Album Screen UI:

<img src='https://media.giphy.com/media/cimvuohY0zd4VmbQbn/giphy.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />
    
Playlist Screen FrontEnd Layout:

<img src='https://media.giphy.com/media/RCLiPVVkrdNhfOW2Mx/giphy.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

## Leonardo Osorio

Show all the code created:

<img src='https://media.giphy.com/media/8o3YV5HK6cP6c6lPrn/giphy.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

Workflow of Playlist:

<img src='https://media.giphy.com/media/galv34LoIdVz1iPTaQ/giphy.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

Workflow of Tracks:

<img src='https://media.giphy.com/media/mOJrACSKkpamWSfQLe/giphy.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

Workflow of Album:

<img src='https://media.giphy.com/media/B9PviSP8HN6FO54qE1/giphy.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

<img src='https://media.giphy.com/media/vTlF27iXZzmU3BkIxI/giphy.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

Workflow of User:

<img src='https://media.giphy.com/media/F040el5AAXpKPknkpq/giphy.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

<img src='https://media.giphy.com/media/SChC5HBkIKMj296XJS/giphy.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

## Carter Sellgren

Create classes for different items returned by API:

<img src='https://i.imgur.com/JCfiATk.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

## Nelly Delgado

Search Screen Layout: 

<img src='http://g.recordit.co/T1F43FiWlF.gif' title='Video Walkthrough' width='300' alt='Video Walkthrough' />


## Sprint 1

## Nelson Mendez

Login Screen UI:

<img src='https://media.giphy.com/media/48hmYTAOWagJCGdI5q/giphy.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

Home Screen UI with horizontal scrolling per category: 

<img src='https://media.giphy.com/media/X4ysNFR8KFwMLBlpxo/giphy.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

## Leonardo Osorio

Configure Parse Server:

<img src='https://media.giphy.com/media/j0DWQlOuOeMo4eqCDW/giphy.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

<img src='https://media.giphy.com/media/06mPBij1oSqjRBVHkE/giphy.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

Setting up functionality to be used with View Controllers and Parse Server:

<img src='https://media.giphy.com/media/LVrZUhzTt7w2RiG0y6/giphy.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

<img src='https://media.giphy.com/media/n13djs2mMNCipKZBrQ/giphy.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

<img src='https://media.giphy.com/media/Td30Fqpgm6Nq3K7fmt/giphy.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

<img src='https://media.giphy.com/media/hC7HrC2I9NMFmmm1AN/giphy.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

<img src='https://media.giphy.com/media/SJijqjSi4Fof0aJpLu/giphy.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

## Carter Sellgren

Initialize code project and Music API:

<img src='https://i.imgur.com/Al6gtAS.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

## Nelly Delgado

Show Track Info and Artist Info:

<img src='http://g.recordit.co/y7O3RFXOh3.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />


## Authors

Leonardo Osorio
Nelson Mendez
Nelly Delgado
Carter Sellgren
