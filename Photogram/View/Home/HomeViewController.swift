//
//  HomeViewController.swift
//  Photogram
//
//  Created by 장혜성 on 2023/08/31.
//

import UIKit
import Kingfisher

// protocol 로 선택액션 전달
// 프로토콜은 구조체, 열거형, 클래스에 다 사용이 가능하다
// AnyObject - 클래스에서만 프로토콜을 정의할 수 있도록 제약
protocol HomeViewProtocol: AnyObject {
    func didSelectItemAt(indexPath: IndexPath)
}

class HomeViewController: BaseViewController {
    
    var list: Photo = Photo(total: 0, total_pages: 0, results: [])
    let mainView = HomeView()
    
    override func loadView() {
        
//        mainView.delegate = self
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self, #function)
        mainView.collectionView.dataSource = self
        mainView.collectionView.delegate = self
    }
    
    deinit {
        print(self, #function)
    }
    
    override func configureView() {
        APIService.shared.callRequest(query: "turtle") { photo in
            guard let photo else {
                print("Alert 보여주기")
                return
            }
            print("API END")
            self.list = photo
            self.mainView.collectionView.reloadData()
        }
    }
}

extension HomeViewController: HomeViewProtocol {
    // homeView 프로토콜 delegate 패턴
    func didSelectItemAt(indexPath: IndexPath) {
        print(indexPath, #function)
        navigationController?.popViewController(animated: true)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(#function)
        return list.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionCell", for: indexPath) as? SearchCollectionCell else { return UICollectionViewCell() }
        
        let thumb = URL(string: list.results[indexPath.item].urls.thumb)
        DispatchQueue.global().async {
            let data = try! Data(contentsOf: thumb!)
            DispatchQueue.main.async {
                cell.thumbImageView.image = UIImage(data: data)
            }
        }
        
//        cell.thumbImageView.backgroundColor = .blue
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
//        delegate?.didSelectItemAt(indexPath: indexPath)
    }
    
}
