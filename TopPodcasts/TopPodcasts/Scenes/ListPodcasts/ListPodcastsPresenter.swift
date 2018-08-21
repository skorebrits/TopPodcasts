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
    func presentPodcast(response: ListPodcasts.FetchImage.Response)
}

class ListPodcastsPresenter: ListPodcastsPresentationLogic{
    weak var viewController: ListPodcastsDisplayLogic?
  
    // MARK: Do something
    func presentListPodcasts(response: ListPodcasts.ListPodcasts.Response){
        if response.success{
            var displayModels: [ListPodcasts.ListPodcasts.ViewModel.CellDisplayModel] = []
            for podcast in response.podcasts where response.success{
                let displayModel = ListPodcasts.ListPodcasts.ViewModel.CellDisplayModel(name: podcast.name, image: nil)
                displayModels.append(displayModel)
            }
            
            let viewModel = ListPodcasts.ListPodcasts.ViewModel(displayModels: displayModels, errorDisplayModel: nil)
            viewController?.displayListPodcasts(viewModel: viewModel)
        }else if let error = response.error{
            let errorDisplayModel = ListPodcasts.ListPodcasts.ViewModel.ErrorDisplayModel(message: ErrorMessage.ItunesServiceError.errorMessage(error: error))
            let viewModel = ListPodcasts.ListPodcasts.ViewModel(displayModels: [], errorDisplayModel: errorDisplayModel)
            viewController?.displayError(viewModel: viewModel)
        }
        
    }
    
    func presentPodcast(response: ListPodcasts.FetchImage.Response) {
        let displayedModel = ListPodcasts.ListPodcasts.ViewModel.CellDisplayModel(name: response.podcast.name, image: response.podcast.artwork100Image)
        let viewModel = ListPodcasts.FetchImage.ViewModel(response: response, displayModel: displayedModel)
        viewController?.displayPodcast(viewModel: viewModel)
    }
}
