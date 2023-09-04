//
//  URLSessionViewController.swift
//  Photogram
//
//  Created by 장혜성 on 2023/08/30.
//

import UIKit
import SnapKit

class URLSessionViewController: BaseViewController {
    
    var session: URLSession!
    
    var total: Double = 0
    
    var buffer: Data? {
        didSet {
            let result = Double(buffer?.count ?? 0) / total
            if result > 0 {
                progressLabel.text = "\(Int(result * 100))%"
                print("result =", result)
            }
        }
    }
    
    let progressLabel = {
        let view = UILabel()
        view.backgroundColor = .black
        view.textColor = .white
        view.text = "0%"
        return view
    }()
    
    let imageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    override func configureView() {
        view.backgroundColor = .white
        view.addSubview(progressLabel)
        view.addSubview(imageView)
        
        progressLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(100)
        }
        
        imageView.snp.makeConstraints {
            $0.size.equalTo(200)
            $0.center.equalToSuperview()
        }
    }
    
    override func setConstraints() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buffer = Data()     // buffer 인스턴스 생성
        
        let url = URL(string: "https://apod.nasa.gov/apod/image/2308/M66_JwstTomlinson_3521.jpg")
        let request = URLRequest(url: url!)
//        session = URLSession.shared     // completeion Handler 로 만 사용가능
        session = URLSession(configuration: .default, delegate: self, delegateQueue: .main)
        session.dataTask(with: request).resume()
    }
    
    // 카카오톡 사진 다운로드: 다운로드 중에 다른 채팅방으로 넘어가면? or 취소버튼?
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // 취소 액션 (화면이 사라질 때 등)
        // 중단시켜버리는 코드
        session.invalidateAndCancel()
        
        // 기다렸다가 리소스 끝나면 정리 - 다운로드 중인게 있으면 끝난후 취소
        session.finishTasksAndInvalidate()
    }
}

// completeHandler 와 어떤 차이가 있는지 확인
extension URLSessionViewController: URLSessionDataDelegate {
    // 서버에서 최초로 응답 받은 경우에 호출 (상태코드 처리)
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse) async -> URLSession.ResponseDisposition {
        print("RESPONSE", response)
        
        if let response = response as? HTTPURLResponse,
           (200...500).contains(response.statusCode) {
            total = Double(response.value(forHTTPHeaderField: "Content-Length")!)!
            return .allow
        } else {
            return .cancel
        }
    }
    
    // 서버에서 데이터 받을 때마다 반복적으로 호출
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        print("DATA: ", data)
        // buffer 가 nil 이면 append 가 실행되지 않음
        buffer?.append(data)
        
    }
    
    // 서버에서 응답이 완료가 된 이후에 호출
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        print("END", error)
        
        if let error {
            print(error)
        } else {
            
            guard let buffer = buffer else {
                print(error)
                return
            }
            
            imageView.image = UIImage(data: buffer)
        }
    }
    
}
