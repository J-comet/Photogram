//
//  SearchView.swift
//  Photogram
//
//  Created by 장혜성 on 2023/08/28.
//

import UIKit

class SearchView: BaseView {
    
    let searchBar = {
        let view = UISearchBar()
        view.placeholder = "검색어를 입력해주세요"
        return view
    }()
    
    lazy var collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.collectionViewLayout())
        view.register(SearchCollectionCell.self, forCellWithReuseIdentifier: "SearchCollectionCell")
        return view
    }()
    
    override func configureView() {
        addSubview(searchBar)
        addSubview(collectionView)
    }
    
    override func setConstraints() {
        searchBar.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
        }
        collectionView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.top.equalTo(searchBar.snp.bottom)
        }
    }
    
    private func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 0
        let size = UIScreen.main.bounds.width - 40
        layout.itemSize = CGSize(width: size / 4, height: size / 4)
        return layout
    }
}
