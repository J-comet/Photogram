//
//  ContentViewController.swift
//  Photogram
//
//  Created by 장혜성 on 2023/08/29.
//

import UIKit
import SnapKit

class ContentViewController: BaseViewController {
    
    let textview = {
        let view = UITextView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    let sampleview = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    let greenView = {
        let view = UIView()
        view.backgroundColor = .systemGreen
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
    
    deinit {
        print("deinit", self)
    }
    
    @objc func naviBarRightButtonClicked() {
        completionHandler?(textview.text!)
        navigationController?.popViewController(animated: true)
    }
    
    override func configureView() {
        super.configureView()
        view.addSubview(textview)
        view.addSubview(sampleview)
        view.addSubview(greenView)
        setAnimation()
    }
    
    override func setConstraints() {
        textview.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.horizontalEdges.equalToSuperview().inset(10)
            $0.height.equalTo(200)
        }
        
        sampleview.snp.makeConstraints {
            $0.center.equalTo(view)
//            $0.top.equalTo(textveiw.snp.bottom).offset(20)
            $0.size.equalTo(100)
        }
        
        greenView.snp.makeConstraints {
            $0.size.equalTo(100)
            $0.top.equalTo(sampleview.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
    }
    
    func setAnimation() {
        // 1. 애니매이션 시작 정의
        sampleview.alpha = 0
        greenView.alpha = 0
        
        // 2. 애니매이션 종료 정의
        UIView.animate(withDuration: 1, delay: 2, options: [.curveLinear]) {
            self.sampleview.alpha = 1
            self.sampleview.backgroundColor = .black
        } completion: { completion in
            if completion {
                // autoreverse 때문에 completion 내 함수가 호출 되지 않음
                UIView.animate(withDuration: 1) {
                    self.greenView.alpha = 1
                }
            }
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        DispatchQueue.main.async {
            self.greenView.alpha = 1
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear) {
                self.greenView.alpha = 0.5
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        DispatchQueue.main.async {
            self.greenView.alpha = 0.5
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear) {
                self.greenView.alpha = 1
            }
        }
    }
}
