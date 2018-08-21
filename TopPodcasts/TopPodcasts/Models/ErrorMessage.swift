//
//  ErrorMessage.swift
//  TopPodcasts
//
//  Created by Sander Korebrits on 17/08/2018.
//  Copyright © 2018 designlapp. All rights reserved.
//

import Foundation

enum ErrorMessage{
    enum ItunesServiceError: String{
        case malformedJSON = "There seems to be a problem with the iTunes Service"
        case networkError = "There seems to be a problem wit your network, please connect to the internet"
        
        var str: String{
            return self.rawValue
        }
        
        static func errorMessage(error: ItunesService.ItunesServiceError) -> String{
            switch error {
            case .malformdJSON:
                return ErrorMessage.ItunesServiceError.malformedJSON.str
            case .network:
                return ErrorMessage.ItunesServiceError.networkError.str
            }
        }
    }
}
