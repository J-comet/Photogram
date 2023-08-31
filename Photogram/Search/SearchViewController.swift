//
//  SearchViewController.swift
//  Photogram
//
//  Created by 장혜성 on 2023/08/28.
//

import UIKit
import Kingfisher

class SearchViewController: BaseViewController {

    let mainView = SearchView()
    
    let systemImages = ["pencil", "star", "person", "star.fill", "xmark", "person.circle"]
    
    var images: [UnSplashSearchImageResult] = []
    
    weak var delegate: PassImageDelegate?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // addObserver 보다 post 가 먼저 신호를 보내면 받을 수 없다.
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(recommandKeywordNotificationObserver(notification: )),
            name: .recommendKeyword,
            object: nil
        )
        
        // 첫번째로 반응할 수 있게 => 바로 소프트키보드가 올라옴
        mainView.searchBar.becomeFirstResponder()
        mainView.searchBar.delegate = self
    }
    
    @objc
    func recommandKeywordNotificationObserver(notification: NSNotification){
        print(#function)
    }
    
    override func configureView() {
        super.configureView()
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        
        UnSplashAPIService.shared.call(
            responseData: UnSplashSearchImage.self,
            parameterDic: [
                "query": "sky",
                "page": "\(1)",
                "per_page": 20
            ]
        ) { response in
            print(response)
            self.images = response.results
            self.mainView.collectionView.reloadData()
        } failure: { error in
            print(error)
        } end: { endUrl in
            print(endUrl)
        }
    }

}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        // 소프트키보드 내리기
        mainView.searchBar.resignFirstResponder()
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionCell", for: indexPath) as? SearchCollectionCell else { return UICollectionViewCell() }
        
        if let url = URL(string: images[indexPath.row].urls.thumb) {
            cell.thumbImageView.kf.setImage(with: url)
        }
//        cell.thumbImageView.image = UIImage(systemName: systemImages[indexPath.row])
        return cell
    }
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // 노티피케이션으로 값 전달
//        NotificationCenter.default.post(
//            name: .selectImage,
//            object: nil,
//            userInfo: ["name": systemImages[indexPath.row], "sample":"밥밥밥"]
//        )
        
        // protocol 값 전달
//        delegate?.receiveImage(image: systemImages[indexPath.row])
        delegate?.receiveImage(image: images[indexPath.row].urls.thumb)
        
        
        dismiss(animated: true) {
            print("종료")
        }
    }
}
