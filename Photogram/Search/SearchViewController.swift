//
//  SearchViewController.swift
//  Photogram
//
//  Created by 장혜성 on 2023/08/28.
//

import UIKit

class SearchViewController: BaseViewController {

    let mainView = SearchView()
    
    let imageList = ["pencil", "star", "person", "star.fill", "xmark", "person.circle"]
    
    var delegate: PassImageDelegate?
    
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
    }
    
    @objc
    func recommandKeywordNotificationObserver(notification: NSNotification){
        print(#function)
    }
    
    override func configureView() {
        super.configureView()
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }

}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionCell", for: indexPath) as? SearchCollectionCell else { return UICollectionViewCell() }
        cell.thumbImageView.image = UIImage(systemName: imageList[indexPath.row])
        return cell
    }
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // 노티피케이션으로 값 전달
//        NotificationCenter.default.post(
//            name: .selectImage,
//            object: nil,
//            userInfo: ["name": imageList[indexPath.row], "sample":"밥밥밥"]
//        )
        
        // protocol 값 전달
        delegate?.receiveImage(image: imageList[indexPath.row])
        
        dismiss(animated: true) {
            print("종료")
        }
    }
}
