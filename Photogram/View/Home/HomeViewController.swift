//
//  HomeViewController.swift
//  Photogram
//
//  Created by 장혜성 on 2023/08/31.
//

import UIKit

// protocol 로 선택액션 전달
// 프로토콜은 구조체, 열거형, 클래스에 다 사용이 가능하다
// AnyObject - 클래스에서만 프로토콜을 정의할 수 있도록 제약
protocol HomeViewProtocol: AnyObject {
    func didSelectItemAt(indexPath: IndexPath)
}

class HomeViewController: BaseViewController {
    
    override func loadView() {
        let mainView = HomeView()
        mainView.delegate = self
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self, #function)
    }
    
    deinit {
        print(self, #function)
    }
    
    override func configureView() {
        
    }
}

extension HomeViewController: HomeViewProtocol {
    // homeView 프로토콜 delegate 패턴
    func didSelectItemAt(indexPath: IndexPath) {
        print(indexPath, #function)
        navigationController?.popViewController(animated: true)
    }
}
