//
//  AddView.swift
//  Photogram
//
//  Created by 장혜성 on 2023/08/28.
//

import UIKit

class AddView: BaseView {
    
    let photoImageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let searchButton = {
        let view = UIButton()
        view.backgroundColor = .green
        return view
    }()
    
    override func configureView() {
        addSubview(photoImageView)
        addSubview(searchButton)
    }
    
    override func setConstraints() {
        photoImageView.snp.makeConstraints {
            $0.topMargin.leftMargin.trailingMargin.equalTo(safeAreaLayoutGuide).inset(10)
            $0.height.equalTo(self).multipliedBy(0.3)
        }
        
        searchButton.snp.makeConstraints {
            $0.size.equalTo(50)
            $0.bottom.trailing.equalTo(photoImageView)
        }
    }
}
