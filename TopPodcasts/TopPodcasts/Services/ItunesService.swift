//
//  ItunesService.swift
//  TopPodcasts
//
//  Created by Sander Korebrits on 17/08/2018.
//  Copyright © 2018 designlapp. All rights reserved.
//

import UIKit

import Alamofire

class ItunesService{
    enum ItunesServiceError: Error{
        case malformdJSON
        case network
    }
    
    enum FeedResult{
        case success(Feed)
        case error(ItunesServiceError)
    }
    
    enum ImageResult{
        case success(UIImage)
        case error(ItunesServiceError)
    }
    
    class func fetchTopPodcasts(completion: @escaping (_ result: ItunesService.FeedResult) -> Void){
        Alamofire.request("https://rss.itunes.apple.com/api/v1/nl/podcasts/top-podcasts/all/25/explicit.json").responseData { (dataResponse) in
            if let data = dataResponse.data,
                dataResponse.result.isSuccess{
                let decoder = JSONDecoder()
                do{
                    let json = try decoder.decode([String: Feed].self, from: data)
                    guard let feed = json["feed"] else {
                        completion(ItunesService.FeedResult.error(ItunesService.ItunesServiceError.malformdJSON))
                        return
                    }
                    completion(ItunesService.FeedResult.success(feed))
                }catch{
                    //MARK: Error JSON
                    completion(ItunesService.FeedResult.error(ItunesService.ItunesServiceError.malformdJSON))
                }
            }else{
                //MARK: Error Connection
                completion(ItunesService.FeedResult.error(ItunesService.ItunesServiceError.network))
            }
        }
    }
    
    class func fetchImage(url: String, completion: @escaping (_ result: ItunesService.ImageResult) -> Void){
        Alamofire.request(url).responseData { (dataResponse) in
            if let data = dataResponse.result.value,
                dataResponse.result.isSuccess{
                guard let image = UIImage(data: data) else{
                    completion(ItunesService.ImageResult.error(ItunesService.ItunesServiceError.network))
                    return
                }
                completion(ItunesService.ImageResult.success(image))
            }else{
                //MARK: Error Connection
                completion(ItunesService.ImageResult.error(ItunesService.ItunesServiceError.network))
            }
        }
    }
}
