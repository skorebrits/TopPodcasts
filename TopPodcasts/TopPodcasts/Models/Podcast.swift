//
//  Podcast.swift
//  Demo
//
//  Created by Sander Korebrits on 14/08/2018.
//  Copyright © 2018 designlapp. All rights reserved.
//

import UIKit

/*
 feed =     {
 
     author =         {
     name = "iTunes Store";
     uri = "http://wwww.apple.com/nl/itunes/";
     };
     copyright = "Copyright \U00a9 2018 Apple Inc. All rights reserved.";
     country = nl;
     icon = "http://itunes.apple.com/favicon.ico";
     id = "https://rss.itunes.apple.com/api/v1/nl/podcasts/top-podcasts/all/25/explicit.json";
     links =         (
     {
     self = "https://rss.itunes.apple.com/api/v1/nl/podcasts/top-podcasts/all/25/explicit.json";
     },
     {
     alternate = "https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewTop?genreId=26&popId=28";
     }
     );
     results =         (
 
         {
         artistName = "NPO Radio 1 / VPRO";
         artworkUrl100 = "https://is4-ssl.mzstatic.com/image/thumb/Music118/v4/2b/0c/15/2b0c15ea-3ac8-71ad-ffda-f8806de09a6c/source/200x200bb.png";
         copyright = "\U00a9 NPO Radio 1 / VPRO";
         genres =                 (
         {
         genreId = 1324;
         name = "Maatschappij en cultuur";
         url = "https://itunes.apple.com/nl/genre/id1324";
         },
         {
         genreId = 26;
         name = Podcasts;
         url = "https://itunes.apple.com/nl/genre/id26";
         }
         );
         id = 1412808006;
         kind = podcast;
         name = "VPRO Zomergasten";
         releaseDate = "2018-08-08";
         url = "https://itunes.apple.com/nl/podcast/vpro-zomergasten/id1412808006?mt=2";
         },
 */
struct Feed: Codable{
    let title: String?
    let author: Author?
    let copyright: String?
    let country: CountryCode?
    let icon: String?
    let id: String?
    let links: [[String: String]]
    let results: [Podcast]
    
    struct Author: Codable{
        let name: String?
        let uri: String?
    }

    enum CountryCode: String, Codable{
        case nl = "nl"
    }
}

struct Podcast: Codable{
    let artistName: String
    let artworkUrl100: String
    let copyright: String
    let id: String
    let name: String
    let releaseDate: String
    let url: String
    let genres: [Genre]
    var artwork100ImageData: Data?
    var artwork100Image: UIImage?{
        get{
        guard let data = artwork100ImageData else{
            return nil
        }
        return UIImage(data: data)
        }
        set(image){
            guard let unwrappedImage = image else{
                self.artwork100ImageData = nil
                return
            }
            self.artwork100ImageData = UIImageJPEGRepresentation(unwrappedImage, 1.0)
        }
    }
    
    enum JSONKeys: String, CodingKey{
        case artistName = "artistName"
        case artworkUrl100 = "artworkUrl100"
        case copyright = "copyright"
        case id = "id"
        case name = "name"
        case releaseDate = "releaseDate"
        case url = "url"
        case genres = "genres"
    }
    
    struct Genre: Codable, Equatable{
        let genreId: String
        let name: String
        let url: String
        
        enum JSONKeys: String, CodingKey{
            case genreId = "genreId"
            case name = "name"
            case url = "url"
        }
        
        init(from decoder: Decoder) throws{
            let container = try decoder.container(keyedBy: Podcast.Genre.JSONKeys.self)
            
            genreId = try container.decodeIfPresent(String.self, forKey: .genreId) ?? ""
            name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
            url = try container.decodeIfPresent(String.self, forKey: .url) ?? ""
        }
        
        init(genreId: String, name: String, url: String){
            self.genreId = genreId
            self.name = name
            self.url = url
        }
        
        static func == (lhs: Genre, rhs: Genre) -> Bool {
            return lhs.name == rhs.name &&
                lhs.genreId == rhs.genreId &&
                lhs.url == rhs.url
        }
    }
    
    init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: Podcast.JSONKeys.self)
        
        artistName = try container.decodeIfPresent(String.self, forKey: .artistName) ?? ""
        artworkUrl100 = try container.decodeIfPresent(String.self, forKey: .artworkUrl100) ?? ""
        copyright = try container.decodeIfPresent(String.self, forKey: .copyright) ?? ""
        id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate) ?? ""
        url = try container.decodeIfPresent(String.self, forKey: .url) ?? ""
        genres = try container.decodeIfPresent([Genre].self, forKey: .genres) ?? []
        artwork100ImageData = nil
    }
    
    init(){
        artistName = ""
        artworkUrl100 = ""
        copyright = ""
        id = ""
        name = ""
        releaseDate = ""
        url = ""
        genres = []
        artwork100ImageData = nil
    }
}





