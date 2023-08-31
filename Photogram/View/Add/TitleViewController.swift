//
//  TitleViewController.swift
//  Photogram
//
//  Created by 장혜성 on 2023/08/29.
//

import UIKit
import SnapKit

class TitleViewController: BaseViewController {

    let titleField = {
        let view = UITextField()
        view.placeholder = "제목을 입력해주세요"
        return view
    }()
    
    // 1. 클로저 값 전달
    var completionHandler: ((String, Int, Bool) -> Void)?
    
    override func configureView() {
        super.configureView()
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "완료",
            style: .plain,
            target: self,
            action: #selector(doneButtonClicked)
        )
        view.addSubview(titleField)
    }
    
    @objc func doneButtonClicked() {
        // 2. 클로저 값 전달
        completionHandler?(titleField.text!, 10, true)
        navigationController?.popViewController(animated: true)
    }
    
    override func setConstraints() {
        titleField.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.height.equalTo(50)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // 2. 클로저 값 전달
//        completionHandler?(titleField.text!)
    }

}
