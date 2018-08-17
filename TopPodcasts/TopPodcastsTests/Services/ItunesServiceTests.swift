//
//  ItunesServiceTests.swift
//  TopPodcastsTests
//
//  Created by Sander Korebrits on 17/08/2018.
//  Copyright © 2018 designlapp. All rights reserved.
//

import XCTest

@testable import TopPodcasts
import OHHTTPStubs

class ItunesServiceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        OHHTTPStubs.removeAllStubs()
    }
    
    func testShouldReturnPodcasts(){
        /*
         https://rss.itunes.apple.com/api/v1/nl/podcasts/top-podcasts/all/25/explicit.json
         */
        let bundle = Bundle(for: type(of: self))
        stub(condition: isHost("rss.itunes.apple.com")) { (request) -> OHHTTPStubsResponse in
            return OHHTTPStubsResponse(fileURL: bundle.url(forResource: "TopPodcastsResponse", withExtension: "json")!, statusCode: 200, headers: nil)
        }
        
        let excepting = XCTestExpectation(description: "Should Return Podcasts")
        ItunesService.fetchTopPodcasts { (result) in
            switch result{
            case .success(let feed):
                XCTAssertEqual(feed.results.count, 25)
            case .error(_):
                XCTFail()
            }
            excepting.fulfill()
        }
        wait(for: [excepting], timeout: 5)
    }
    
    func testShouldErrorOnMalformdJSON(){
        let excepting = XCTestExpectation(description: "Should error on malformd JSON")
        let bundle = Bundle(for: type(of: self))
        stub(condition: isHost("rss.itunes.apple.com")) { (request) -> OHHTTPStubsResponse in
            return OHHTTPStubsResponse(fileURL: bundle.url(forResource: "MalformdJSON", withExtension: "json")!, statusCode: 200, headers: nil)
        }
        ItunesService.fetchTopPodcasts { (result) in
            switch result{
            case .success(_):
                XCTFail()
            case .error(let error):
                XCTAssertEqual(ItunesService.Result.ItunesServiceError.malformdJSON, error)
            }
            excepting.fulfill()
        }
        wait(for: [excepting], timeout: 5)
    }
    
    
    func testShouldErrorOnNoNetwork(){
        let excepting = XCTestExpectation(description: "Should Error on no Network")
        stub(condition: isHost("rss.itunes.apple.com")) { (request) -> OHHTTPStubsResponse in
            let notConnectedError = NSError(domain: NSURLErrorDomain, code: URLError.notConnectedToInternet.rawValue)
            return OHHTTPStubsResponse(error:notConnectedError)
        }
        ItunesService.fetchTopPodcasts { (result) in
            switch result{
            case .success(_):
                XCTFail()
            case .error(let error):
                XCTAssertEqual(ItunesService.Result.ItunesServiceError.network, error)
            }
            excepting.fulfill()
        }
        wait(for: [excepting], timeout: 5)
    }
}
