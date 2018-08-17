//
//  ListPodcastsWorkerTests.swift
//  TopPodcasts
//
//  Created by Sander Korebrits on 17/08/2018.
//  Copyright (c) 2018 designlapp. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

@testable import TopPodcasts
import XCTest
import OHHTTPStubs

class ListPodcastsWorkerTests: XCTestCase{
  
    // MARK: Subject under test
    var sut: ListPodcastsWorker!
  
    // MARK: Test lifecycle
    override func setUp(){
        super.setUp()
        setupListPodcastsWorker()
    }

    override func tearDown(){
        super.tearDown()
        OHHTTPStubs.removeAllStubs()
    }

    // MARK: Test setup

    func setupListPodcastsWorker(){
        sut = ListPodcastsWorker()
    }

    // MARK: Test doubles

    // MARK: Tests
    func testListPodcastShouldReturnPodcasts(){
        /*
         https://rss.itunes.apple.com/api/v1/nl/podcasts/top-podcasts/all/25/explicit.json
         */
        let bundle = Bundle(for: type(of: self))
        stub(condition: isHost("rss.itunes.apple.com")) { (request) -> OHHTTPStubsResponse in
            return OHHTTPStubsResponse(fileURL: bundle.url(forResource: "TopPodcastsResponse", withExtension: "json")!, statusCode: 200, headers: nil)
        }
        
        let excepting = XCTestExpectation(description: "Should Return Podcasts")
        sut.listPodcasts { (succes, podcasts, errorMessage) in
            XCTAssertEqual(succes, true)
            XCTAssertNil(errorMessage, "error message should be nil")
            XCTAssertEqual(podcasts.count, 25)
            excepting.fulfill()
        }
        wait(for: [excepting], timeout: 5)
    }
    
    func testListPodcastsShouldError(){
        let excepting = XCTestExpectation(description: "Should Error on no Network")
        stub(condition: isHost("rss.itunes.apple.com")) { (request) -> OHHTTPStubsResponse in
            let notConnectedError = NSError(domain: NSURLErrorDomain, code: URLError.notConnectedToInternet.rawValue)
            return OHHTTPStubsResponse(error:notConnectedError)
        }
        sut.listPodcasts { (succes, podcasts, errorMessage) in
            XCTAssertEqual(succes, false)
            XCTAssertEqual(podcasts.count, 0)
            XCTAssertNotNil(errorMessage)
            excepting.fulfill()
        }
        wait(for: [excepting], timeout: 5)
    }
}