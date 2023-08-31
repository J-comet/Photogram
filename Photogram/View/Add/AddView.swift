//
//  AddView.swift
//  Photogram
//
//  Created by 장혜성 on 2023/08/28.
//

import UIKit
import SnapKit

class AddView: BaseView {
    
    let photoImageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let searchButton = {
        let view = UIButton()
        view.setTitle("노티피케이션 전달", for: .normal)
        view.backgroundColor = .blue
        return view
    }()
    
    let dateButton = {
        let view = UIButton()
        view.backgroundColor = .green
        view.setTitle(DateFormatter.today(), for: .normal)
        return view
    }()
    
    let searchProtocolButton = {
        let view = UIButton()
        view.setTitle("프로토콜 전달", for: .normal)
        view.backgroundColor = .brown
        return view
    }()
    
    let titleButton = {
        let view = UIButton()
        view.backgroundColor = .link
        view.setTitle("오늘의 사진", for: .normal)
        return view
    }()
    
    let contentButton = {
        let view = UIButton()
        view.backgroundColor = .magenta
        view.setTitle("컨텐츠 등록", for: .normal)
        return view
    }()
    
    override func configureView() {
        addSubview(photoImageView)
        addSubview(searchButton)
        addSubview(dateButton)
        addSubview(searchProtocolButton)
        addSubview(titleButton)
        addSubview(contentButton)
    }
    
    override func setConstraints() {
        photoImageView.snp.makeConstraints {
            $0.topMargin.leftMargin.trailingMargin.equalTo(safeAreaLayoutGuide).inset(10)
            $0.height.equalTo(self).multipliedBy(0.3)
        }
        
        searchButton.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.bottom.trailing.equalTo(photoImageView)
        }
        
        dateButton.snp.makeConstraints {
            $0.top.equalTo(photoImageView.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            $0.height.equalTo(50)
        }
        
        searchProtocolButton.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.bottom.leading.equalTo(photoImageView)
        }
        
        titleButton.snp.makeConstraints {
            $0.top.equalTo(dateButton.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            $0.height.equalTo(50)
        }
        
        contentButton.snp.makeConstraints {
            $0.top.equalTo(titleButton.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(titleButton)
            $0.height.equalTo(50)
        }
    }
}
