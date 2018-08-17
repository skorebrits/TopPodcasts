//
//  ItunesService.swift
//  TopPodcasts
//
//  Created by Sander Korebrits on 17/08/2018.
//  Copyright © 2018 designlapp. All rights reserved.
//

import Foundation

import Alamofire

class ItunesService{
    enum Result{
        case success(Feed)
        case error(ItunesServiceError)
        enum ItunesServiceError: Error{
            case malformdJSON
            case network
        }
    }
    
    class func fetchTopPodcasts(completion: @escaping (_ result: ItunesService.Result) -> Void){
        Alamofire.request("https://rss.itunes.apple.com/api/v1/nl/podcasts/top-podcasts/all/25/explicit.json").responseData { (dataResponse) in
            if let data = dataResponse.data,
                dataResponse.result.isSuccess{
                let decoder = JSONDecoder()
                do{
                    let json = try decoder.decode([String: Feed].self, from: data)
                    guard let feed = json["feed"] else {
                        completion(ItunesService.Result.error(ItunesService.Result.ItunesServiceError.malformdJSON))
                        return
                    }
                    completion(ItunesService.Result.success(feed))
                }catch{
                    //MARK: Error JSON
                    completion(ItunesService.Result.error(ItunesService.Result.ItunesServiceError.malformdJSON))
                }
            }else{
                //MARK: Error Connection
                completion(ItunesService.Result.error(ItunesService.Result.ItunesServiceError.network))
            }
        }
    }
}
