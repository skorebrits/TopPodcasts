//
//  ShowPodcastPresenterTests.swift
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

class ShowPodcastPresenterTests: XCTestCase{
    
    // MARK: Subject under test
    var sut: ShowPodcastPresenter!

    // MARK: Test lifecycle
    override func setUp(){
        super.setUp()
        setupShowPodcastPresenter()
    }

    override func tearDown(){
        super.tearDown()
    }

    // MARK: Test setup
    func setupShowPodcastPresenter(){
        sut = ShowPodcastPresenter()
    }

    // MARK: Test doubles
    class ShowPodcastDisplayLogicSpy: ShowPodcastDisplayLogic{
        var displayGetPodcastCalled = false

        func displayGetPodcast(viewModel: ShowPodcast.GetPodcast.ViewModel){
            displayGetPodcastCalled = true
        }
    }

    // MARK: Tests
    func testPresentGetPodcast(){
        
        // Given
        let spy = ShowPodcastDisplayLogicSpy()
        sut.viewController = spy
        let response = ShowPodcast.GetPodcast.Response(podcast: Podcast())

        // When
        sut.presentGetPodcast(response: response)

        // Then
        XCTAssertTrue(spy.displayGetPodcastCalled, "presentSomething(response:) should ask the view controller to display the result")
    }
}
