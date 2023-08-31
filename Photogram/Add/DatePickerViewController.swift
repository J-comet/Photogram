//
//  DatePickerViewController.swift
//  Photogram
//
//  Created by 장혜성 on 2023/08/29.
//

import UIKit

class DatePickerViewController: BaseViewController {

    let mainView = DateView()
    
    // 2. Protocol 값 전달
    var delegate: PassDateDelegate?
    
    override func loadView() {
        self.view = mainView
    }
    
    // 3. Protocol 값 전달
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        delegate?.receiveDate(date: mainView.datePickerView.date)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    deinit {
        print("deinit", self)
    }

}
