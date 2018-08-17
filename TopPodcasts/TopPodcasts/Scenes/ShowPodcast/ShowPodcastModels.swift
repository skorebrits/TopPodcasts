//
//  ShowPodcastModels.swift
//  TopPodcasts
//
//  Created by Sander Korebrits on 17/08/2018.
//  Copyright (c) 2018 designlapp. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum ShowPodcast{
  enum GetPodcast{
    struct Request{
        
    }
    
    struct Response{
        var podcast: Podcast
    }
    
    struct ViewModel{
        var artistName: String
        var copyright: String
        var name: String
        var releaseDate: String
        var genres: String
        
        static func emptyViewModel() -> ViewModel{
            return ViewModel(artistName: "-", copyright: "-", name: "-", releaseDate: "-", genres: "-")
        }
    }
  }
}
