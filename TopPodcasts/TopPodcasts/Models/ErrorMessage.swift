//
//  ErrorMessage.swift
//  TopPodcasts
//
//  Created by Sander Korebrits on 17/08/2018.
//  Copyright © 2018 designlapp. All rights reserved.
//

import Foundation

enum ErrorMessage{
    enum ItunesService: String{
        case malformedJSON = "There seems to be a problem with the iTunes Service"
        case networkError = "There seems to be a problem wit your network, please connect to the internet"
        
        var str: String{
            return self.rawValue
        }
    }
}
