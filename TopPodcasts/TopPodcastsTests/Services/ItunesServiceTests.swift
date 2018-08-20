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
    
    func testFetchTopPodcastsShouldReturnPodcasts(){
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
    
    func testFetchTopPodcastsShouldErrorOnMalformdJSON(){
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
                XCTAssertEqual(ItunesService.ItunesServiceError.malformdJSON, error)
            }
            excepting.fulfill()
        }
        wait(for: [excepting], timeout: 5)
    }
    
    
    func testFetchTopPodcastsShouldErrorOnNoNetwork(){
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
                XCTAssertEqual(ItunesService.ItunesServiceError.network, error)
            }
            excepting.fulfill()
        }
        wait(for: [excepting], timeout: 5)
    }
    
    func testFetchImageShouldRetrieveImage(){
        let excepting = XCTestExpectation(description: "Should fech image")
        let bundle = Bundle(for: type(of: self))
        stub(condition: isHost("is4-ssl.mzstatic.com")) { (request) -> OHHTTPStubsResponse in
            return OHHTTPStubsResponse(fileURL: bundle.url(forResource: "200x200bb", withExtension: "png")!, statusCode: 200, headers: nil)
        }
        ItunesService.fetchImage(url: "https://is4-ssl.mzstatic.com/image/thumb/Music118/v4/2b/0c/15/2b0c15ea-3ac8-71ad-ffda-f8806de09a6c/source/200x200bb.png") { (result) in
            switch result{
            case .success(let image):
                XCTAssertEqual(image.size, CGSize(width: 200, height: 200))
            case .error(_):
                XCTFail()
            }
            excepting.fulfill()
        }
        wait(for: [excepting], timeout: 5)
    }
    
    func testFetchImageShouldErrorOnNoNetwork(){
        let excepting = XCTestExpectation(description: "Should Error on no Network")
        stub(condition: isHost("is4-ssl.mzstatic.com")) { (request) -> OHHTTPStubsResponse in
            let notConnectedError = NSError(domain: NSURLErrorDomain, code: URLError.notConnectedToInternet.rawValue)
            return OHHTTPStubsResponse(error:notConnectedError)
        }
        ItunesService.fetchImage(url: "https://is4-ssl.mzstatic.com/image/thumb/Music118/v4/2b/0c/15/2b0c15ea-3ac8-71ad-ffda-f8806de09a6c/source/200x200bb.png") { (result) in
            switch result{
            case .success(_):
                XCTFail()
            case .error(let error):
                XCTAssertEqual(ItunesService.ItunesServiceError.network, error)
            }
            excepting.fulfill()
        }
        wait(for: [excepting], timeout: 5)
    }
}






