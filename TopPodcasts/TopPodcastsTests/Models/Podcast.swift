//
//  Podcast.swift
//  TopPodcastsTests
//
//  Created by Sander Korebrits on 20/08/2018.
//  Copyright © 2018 designlapp. All rights reserved.
//

import XCTest

@testable import TopPodcasts

class PodcastTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testShouldInitializeWithCorrectValues(){
        let dict: [String: Any] = [
            "artistName" :"NPO Radio 1 / VPRO",
            "artworkUrl100" : "https://is4-ssl.mzstatic.com/image/thumb/Music118/v4/2b/0c/15/2b0c15ea-3ac8-71ad-ffda-f8806de09a6c/source/200x200bb.png",
            "copyright" : "NPO Radio 1 / VPRO",
            "genres" : [
                ["genreId" : "1324",
                "name": "Maatschappij en cultuur",
                "url" : "https://itunes.apple.com/nl/genre/id1324"]
            ],
            "name" : "VPRO Zomergasten",
            "releaseDate" : "2018-08-08",
            "url" : "https://itunes.apple.com/nl/podcast/vpro-zomergasten/id1412808006?mt=2"]
        do{
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: .sortedKeys)
            
            let decoder = JSONDecoder()
            let podcast = try decoder.decode(Podcast.self, from: jsonData)
            XCTAssertEqual(podcast.artistName, dict["artistName"] as! String)
            XCTAssertEqual(podcast.artworkUrl100, dict["artworkUrl100"] as! String)
            XCTAssertEqual(podcast.copyright, dict["copyright"] as! String)
            XCTAssertEqual(podcast.name, dict["name"] as! String)
            XCTAssertEqual(podcast.releaseDate, dict["releaseDate"] as! String)
            XCTAssertEqual(podcast.url, dict["url"] as! String)
            XCTAssertEqual(podcast.genres, [Podcast.Genre(genreId: "1324", name: "Maatschappij en cultuur", url: "https://itunes.apple.com/nl/genre/id1324")])
        }catch let error{
            XCTFail("JSON ERROR: \(error)")
        }
    }
    
    func testShouldInitializeWithEmptyValues(){
        let dict: [String: Any] = [:]
        do{
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: .sortedKeys)
            
            let decoder = JSONDecoder()
            let podcast = try decoder.decode(Podcast.self, from: jsonData)
            XCTAssertEqual(podcast.artistName, "")
            XCTAssertEqual(podcast.artworkUrl100, "")
            XCTAssertEqual(podcast.copyright, "")
            XCTAssertEqual(podcast.name, "")
            XCTAssertEqual(podcast.releaseDate, "")
            XCTAssertEqual(podcast.url, "")
            XCTAssertEqual(podcast.genres, [])
        }catch let error{
            XCTFail("JSON ERROR: \(error)")
        }
    }
}
