//
//  HomeView.swift
//  Photogram
//
//  Created by 장혜성 on 2023/08/31.
//

import UIKit

class HomeView: BaseView {
    
    deinit {
        print("HomeView", #function)
    }
    
    lazy var collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.collectionViewLayout())
        view.register(SearchCollectionCell.self, forCellWithReuseIdentifier: "SearchCollectionCell")
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    // weak는 클래스에서만 대부분 사용, 키워드 사용할 때 AnyObject 를 붙혀서 오류 해결
    weak var delegate: HomeViewProtocol?
    
    override func configureView() {
        addSubview(collectionView)
    }
    
    override func setConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        let size = UIScreen.main.bounds.width - 32
        layout.itemSize = CGSize(width: size / 3, height: size / 3)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        return layout
    }
}

extension HomeView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionCell", for: indexPath) as? SearchCollectionCell else { return UICollectionViewCell() }
        cell.thumbImageView.backgroundColor = .blue
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        delegate?.didSelectItemAt(indexPath: indexPath)
    }
    
    
}
