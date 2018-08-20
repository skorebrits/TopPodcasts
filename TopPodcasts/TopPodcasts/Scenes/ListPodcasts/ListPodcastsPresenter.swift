//
//  ListPodcastsPresenter.swift
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

protocol ListPodcastsPresentationLogic{
    func presentListPodcasts(response: ListPodcasts.ListPodcasts.Response)
}

class ListPodcastsPresenter: ListPodcastsPresentationLogic{
    weak var viewController: ListPodcastsDisplayLogic?
  
    // MARK: Do something
    func presentListPodcasts(response: ListPodcasts.ListPodcasts.Response){
        var displayModels: [ListPodcasts.ListPodcasts.ViewModel.CellDisplayModel] = []
        for podcast in response.podcasts where response.success{
            let displayModel = ListPodcasts.ListPodcasts.ViewModel.CellDisplayModel(name: podcast.name, image: nil)
            displayModels.append(displayModel)
        }
        
        let viewModel = ListPodcasts.ListPodcasts.ViewModel(response: response, displayModels: displayModels)
        viewController?.displayListPodcasts(viewModel: viewModel)
    }
}
