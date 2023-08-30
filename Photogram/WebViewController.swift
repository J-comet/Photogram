//
//  WebViewController.swift
//  Photogram
//
//  Created by 장혜성 on 2023/08/29.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate {
    
    var webView = WKWebView()
    
//    override func loadView() {
//        let webConfiguration = WKWebViewConfiguration()
//        webView = WKWebView(frame: .zero, configuration: webConfiguration)
//        webView.uiDelegate = self
//        view = webView
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(webView)
        webView.snp.makeConstraints {
            $0.edges.equalTo(view).inset(100)
        }
        
        let myURL = URL(string:"https://www.apple.com")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
        // 네비게이션 컨트롤러가 처음에 투명, 스크롤 하면 불투명
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .red
        navigationController?.navigationBar.isTranslucent = false       // safeArea 영역이 변경됨. (스토리보드에서 확인하면 이해 쉬움)
        
        navigationController?.navigationBar.standardAppearance = appearance       // 스크롤할 때 색상 적용됨
        navigationController?.navigationBar.scrollEdgeAppearance = appearance  // 스크롤 하기 전 기본상태일 떄 색상이 적용됨
        
        navigationController?.hidesBarsOnSwipe = true // 스와이프할 떄 네비바 Hide 설정
        
        title = "웹뷰 타이틀"
    }
    
    func reloadButtonClicked() {
        webView.reload()
    }
    
    func goBackButtonClicked() {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    func goForwardButtonClicked() {
        if webView.canGoForward {
            webView.goForward()
        }
    }
}
