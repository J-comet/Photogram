//
//  ViewController.swift
//  Photogram
//
//  Created by 장혜성 on 2023/08/28.
//

import UIKit
import SesacFrameWork
import PhotosUI

// protocol  = ? , delegate = ?
// 1. Protocol 값 전달
protocol PassDateDelegate {
    func receiveDate(date: Date)
}

protocol PassImageDelegate {
    func receiveImage(image: String)
}

class AddViewController: BaseViewController {
    
    let mainView = AddView()
    
    // SourceType 촬영, 앨범에 저장, 갤러리 접근
    let picker = UIImagePickerController()
    
    lazy var phpicker = {
        var config = PHPickerConfiguration()
        config.selectionLimit = 1
        config.filter = .any(of: [.livePhotos, .images])
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        return picker
    }()
    
    // viewDidLoad 보다 먼저 호출 됨.
    // 주의! super 메서드 호출 하면 안됨.
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ClassOpenExample.publicExample()
        ClassPublicExample.publicExample()
        //        ClassPublicExample.internalExample()      // 오류
        
        mainView.dateButton.addTarget(self, action: #selector(dateButtonClicked), for: .touchUpInside)
        mainView.searchProtocolButton.addTarget(self, action: #selector(searchProtocolButtonClicked), for: .touchUpInside)
        mainView.titleButton.addTarget(self, action: #selector(titleButtonClicked), for: .touchUpInside)
        mainView.contentButton.addTarget(self, action: #selector(contentButtonClicked), for: .touchUpInside)
        
        //        APIService.shared.callRequest()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // SearchViewController 에서 선택한 이미지 값 받기
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(selectImageNotificationObserver),
            name: .selectImage,
            object: nil
        )
        
        //        sesacShowActivityViewController(image: UIImage(systemName: "star")!, url: "aaa", text: "sddsds")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 옵저버 remove 시키기
        NotificationCenter.default.removeObserver(self, name: .selectImage, object: nil)
    }
    
    @objc func contentButtonClicked() {
        let vc = ContentViewController()
        vc.completionHandler = { content in
            print(content)
            self.mainView.contentButton.setTitle(content, for: .normal)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func titleButtonClicked() {
        let vc = TitleViewController()
        
        // 3. 클로저 값 전달
        vc.completionHandler = { title, age, alarmStatus in
            print(title, age, alarmStatus," ",#function)
            self.mainView.titleButton.setTitle(title, for: .normal)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func searchProtocolButtonClicked() {
        let vc = SearchViewController()
        vc.delegate = self
        present(vc, animated: true)
    }
    
    @objc func dateButtonClicked() {
        // 5. Protocol 값 전달
        let vc = DatePickerViewController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // 이미지 전달받았을 때 처리할 메서드
    @objc func selectImageNotificationObserver(notification: NSNotification) {
        print(#function, "이미지 전달 받음")
        //        print(notification.userInfo?["name"])
        //        print(notification.userInfo?["sample"])
        
        if let name = notification.userInfo?["name"] as? String {
            mainView.photoImageView.image = UIImage(systemName: name)
        }
    }
    
    @objc
    func searchButtonClicked() {
        //        let word = ["Apple","Banana","Cookie","Cake","Sky"]
        //        // 노티피케이션으로 값 전달 실패 = SearchViewController 의 addObserver 가 post 보다 늦게 실행됨.
        //        NotificationCenter.default.post(
        //            name: .recommendKeyword,
        //            object: nil,
        //            userInfo: ["word":word.randomElement()!]
        //        )
        //        present(SearchViewController(), animated: true)
        
        showActionSheet()
    }
    
    override func configureView() {
        super.configureView()
        print(self, #function)
        mainView.searchButton.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)
    }
    
    private func showActionSheet() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "갤러리에서 가져오기", style: .default, handler: { UIAlertAction in
            guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
                print("갤러리 접근 불가능")
                return
            }
            self.present(self.phpicker, animated: true)
        
        }))
        
        actionSheet.addAction(UIAlertAction(title: "웹에서 가져오기", style: .default, handler: { UIAlertAction in
            print("웹")
        }))
        
        actionSheet.addAction(UIAlertAction(title: "취소", style: .cancel))
        present(actionSheet, animated: true, completion: nil)
    }
    
}

// 4. Protocol 값 전달
extension AddViewController: PassDateDelegate {
    func receiveDate(date: Date) {
        mainView.dateButton.setTitle(DateFormatter.convertDate(date: date), for: .normal)
    }
}

extension AddViewController: PassImageDelegate {
    func receiveImage(image: String) {
        mainView.photoImageView.image = UIImage(systemName: image)
    }
}

extension AddViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        let itemProvider = results.first?.itemProvider
        
        if let itemProvider = itemProvider,
           itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                DispatchQueue.main.async {
                    self.mainView.photoImageView.image = image as? UIImage
                }
            }
        } else {
            print("취소")
        }
        
    }
}
