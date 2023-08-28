//
//  ViewController.swift
//  Photogram
//
//  Created by 장혜성 on 2023/08/28.
//

import UIKit

class AddViewController: BaseViewController {

    let mainView = AddView()
    
    // viewDidLoad 보다 먼저 호출 됨.
    // 주의! super 메서드 호출 하면 안됨.
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // SearchViewController 에서 선택한 이미지 값 받기
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(selectImageNotificationObserver),
            name: NSNotification.Name("SelectImage"),
            object: nil
        )
    }
    
    // 이미지 전달받았을 때 처리할 메서드
    @objc func selectImageNotificationObserver(notification: NSNotification) {
        print("이미지 전달 받음")
        print(notification.userInfo?["name"])
        print(notification.userInfo?["sample"])
        
        if let name = notification.userInfo?["name"] as? String {
            mainView.photoImageView.image = UIImage(systemName: name)
        }
    }
    
    @objc
    func searchButtonClicked() {
        
        let word = ["Apple","Banana","Cookie","Cake","Sky"]
        
        // 노티피케이션으로 값 전달
        NotificationCenter.default.post(
            name: NSNotification.Name("RecommandKeyword"),
            object: nil,
            userInfo: ["word":word.randomElement()!]
        )
        present(SearchViewController(), animated: true)
    }

    override func configureView() {
        super.configureView()
        print(self, #function)
        mainView.searchButton.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)
    }

}

