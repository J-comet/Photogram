//
//  APIService.swift
//  Photogram
//
//  Created by 장혜성 on 2023/08/30.
//

import Foundation

class APIService {
    static let shared = APIService()
    private init() {}
    
    func callRequest() {
        
//        let url = URL(string: "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=1081")
        let url = URL(string: "https://apod.nasa.gov/apod/image/2308/M66_JwstTomlinson_3521.jpg")
    
        let request = URLRequest(url: url!)
        
        // completion Handler 방식 - task 다 끝나고 실행
        URLSession.shared.dataTask(with: request) { data, response, error in
            let value = String(data: data!, encoding: .utf8)
            print(value)
            print(response)
            print(error)
        }.resume()
        
        // sessionDelegate 방식 - 최초 응답 / 중간과정 알 수 있음. ex_용량이 큰 이미지 다운로드 진행률
        //                       shared 세션 사용 불가능
    }
    
}
