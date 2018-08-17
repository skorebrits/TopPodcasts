//
//  Podcast.swift
//  Demo
//
//  Created by Sander Korebrits on 14/08/2018.
//  Copyright © 2018 designlapp. All rights reserved.
//

import Foundation

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
    let artistName: String?
    let artworkUrl100: String?
    let copyright: String?
    let id: String?
    let name: String?
    let releaseDate: String?
    let url: String?
    let genres: [Genre]
    
    struct Genre: Codable{
        let genreId: String?
        let name: String?
        let url: String?
    }
    
    static func emptyPodcast() -> Podcast{
        return Podcast(artistName: nil, artworkUrl100: nil, copyright: nil, id: nil, name: nil, releaseDate: nil, url: nil, genres: [])
    }
}





