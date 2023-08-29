//
//  DateView.swift
//  Photogram
//
//  Created by 장혜성 on 2023/08/29.
//

import UIKit
import SnapKit

class DateView: BaseView {
    
    let datePickerView = {
        let view = UIDatePicker()
        view.datePickerMode = .date
        view.preferredDatePickerStyle = .wheels
        return view
    }()
    
    override func configureView() {
        addSubview(datePickerView)
    }
    
    override func setConstraints() {
        datePickerView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
    }
}
