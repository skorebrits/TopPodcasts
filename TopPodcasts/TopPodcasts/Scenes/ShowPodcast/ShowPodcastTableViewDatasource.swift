//
//  ShowPodcastsTableViewDatasource.swift
//  TopPodcasts
//
//  Created by Sander Korebrits on 17/08/2018.
//  Copyright © 2018 designlapp. All rights reserved.
//

import UIKit

class ShowPodcastTableViewDatasource: NSObject{
    weak var tableView: UITableView?
    var viewModel: ShowPodcast.GetPodcast.ViewModel = ShowPodcast.GetPodcast.ViewModel.emptyViewModel()
    var labels = [PodcastLabel.name,
                  PodcastLabel.artistName,
                  PodcastLabel.releaseDate,
                  PodcastLabel.genres,
                  PodcastLabel.copyright]
    
    enum PodcastLabel: String{
        case artistName = "Artist Name:"
        case copyright = "Copyright:"
        case genres = "Genres"
        case name = "Name"
        case releaseDate = "Release Date:"
        
        var str: String{
            return self.rawValue
        }
    }
    
    init(tableView: UITableView){
        self.tableView = tableView
        super.init()
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
        let nibAndIdentifier = ["ShowPodcastImageTableViewCell" : "ShowPodcastImageCell", "ShowPodcastLabelTableViewCell" : "ShowPodcastLabelCell"]
        for (nib, identifier) in nibAndIdentifier{
            self.tableView?.register(UINib(nibName: nib, bundle: Bundle.main), forCellReuseIdentifier: identifier)
        }
    }
}

// MARK: - Methods
extension ShowPodcastTableViewDatasource{
    func updateWithViewModel(viewModel: ShowPodcast.GetPodcast.ViewModel){
        self.viewModel = viewModel
        tableView?.reloadData()
    }
}

extension ShowPodcastTableViewDatasource: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : labels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = indexPath.section == 0 ? "ShowPodcastImageCell" : "ShowPodcastLabelCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        if let showPodcastLabelCell = cell as? ShowPodcastLabelTableViewCell{
            let value: String
            switch labels[indexPath.row]{
            case .artistName:
                value = viewModel.artistName
            case .copyright:
                value = viewModel.copyright
            case .genres:
                value = viewModel.genres
            case .name:
                value = viewModel.name
            case .releaseDate:
                value = viewModel.releaseDate
            }
            showPodcastLabelCell.label.text = labels[indexPath.row].str
            showPodcastLabelCell.valueLabel.text = value
        }
        return cell
    }
}

extension ShowPodcastTableViewDatasource: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? tableView.frame.width : UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}
