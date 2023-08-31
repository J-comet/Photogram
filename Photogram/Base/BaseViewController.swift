//
//  BaseViewController.swift
//  Photogram
//
//  Created by 장혜성 on 2023/08/28.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setConstraints()
    }

    func configureView() {      // addSubView
        view.backgroundColor = .white
        print("Base configureView")
    }
    
    func setConstraints() {     // 제약조건
        print("Base setConstraints")
    }
    
    deinit {
        print("[",String(describing: type(of: self)), "] / [deinit]")
    }
}
