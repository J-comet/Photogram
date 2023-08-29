//
//  ContentViewController.swift
//  Photogram
//
//  Created by 장혜성 on 2023/08/29.
//

import UIKit
import SnapKit

class ContentViewController: BaseViewController {

    let contentField = {
        let view = UITextField()
        view.placeholder = "컨텐츠를 입력해주세요"
        return view
    }()
    
    var completionHandler: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "완료",
            style: .plain,
            target: self,
            action: #selector(naviBarRightButtonClicked)
        )
    }
    
    @objc func naviBarRightButtonClicked() {
        completionHandler?(contentField.text!)
        navigationController?.popViewController(animated: true)
    }
    
    override func configureView() {
        super.configureView()
        view.addSubview(contentField)
    }
    
    override func setConstraints() {
        contentField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.horizontalEdges.equalToSuperview().inset(10)
        }
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        completionHandler?(contentField.text!)
//    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
//        completionHandler?(contentField.text!)
    }

}
