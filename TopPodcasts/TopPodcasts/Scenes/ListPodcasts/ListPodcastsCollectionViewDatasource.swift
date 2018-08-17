//
//  ListPodcastsCollectionViewDatasource.swift
//  TopPodcasts
//
//  Created by Sander Korebrits on 17/08/2018.
//  Copyright © 2018 designlapp. All rights reserved.
//

import UIKit

protocol ListPodcastsCollectionViewDatasourceDelegate: class{
    func listPodcastsDelegateDidSelectIndexPath(indexPath: IndexPath)
}

class ListPodcastsCollectionViewDatasource: NSObject{
    weak var delegate: ListPodcastsCollectionViewDatasourceDelegate?
    weak var collectionView: UICollectionView?
    var layout:UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        return layout
    }
    var cellDisplayModels: [ListPodcasts.ListPodcasts.ViewModel.CellDisplayModel] = []
    
    init(collectionView: UICollectionView){
        self.collectionView = collectionView
        super.init()
        self.collectionView?.dataSource = self
        self.collectionView?.delegate = self
        self.collectionView?.collectionViewLayout = layout
        let nibAndIdentifiers = ["ListPodcastsCollectionViewCell" : "ListPodcastCell", "ListPodcastsEmptyCollectionViewCell" : "ListPodcastEmptyCell"]
        for (nibName, reuseIdentifier) in nibAndIdentifiers{
            self.collectionView?.register(UINib(nibName: nibName, bundle: Bundle.main), forCellWithReuseIdentifier: reuseIdentifier)
        }
    }
}

//MARK: - Methods
extension ListPodcastsCollectionViewDatasource{
    func updateWithViewModel(viewModel: ListPodcasts.ListPodcasts.ViewModel){
        cellDisplayModels = viewModel.displayModels
        collectionView?.reloadData()
    }
}

extension ListPodcastsCollectionViewDatasource: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellDisplayModels.count == 0 ? 1 : cellDisplayModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = cellDisplayModels.count == 0 ? "ListPodcastEmptyCell" : "ListPodcastCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        if let emptyCell = cell as? ListPodcastsEmptyCollectionViewCell{
            emptyCell.label.text = "No Podcasts listed"
        }else if let podcastCell = cell as? ListPodcastsCollectionViewCell{
            podcastCell.label.text = cellDisplayModels[indexPath.row].name
        }
        return cell
    }
}

extension ListPodcastsCollectionViewDatasource: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if cellDisplayModels.count > 0{
            delegate?.listPodcastsDelegateDidSelectIndexPath(indexPath: indexPath)
        }
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension ListPodcastsCollectionViewDatasource: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellDisplayModels.count == 0 ? collectionView.frame.size : CGSize(width: collectionView.frame.size.width / 2.0, height: collectionView.frame.size.width / 2.0)
    }
}
