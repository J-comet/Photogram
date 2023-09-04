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
    
    func callRequest(query: String, completionHandler: @escaping (Photo?) -> Void) {
        
//        let url = URL(string: "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=1081")
        
//        let header: HTTPHeaders = ["Authorization" : "Client-ID \(APIKey.unsplashKey)"]
        let url = "https://api.unsplash.com/search/photos?query=\(query)&client_id=\(APIKey.unsplashKey)&per_page=30"
        guard let unsplashURL = URL(string: url) else { return }
        
//        let url = URL(string: "https://apod.nasa.gov/apod/image/2308/M66_JwstTomlinson_3521.jpg")
    
        let request = URLRequest(url: unsplashURL, timeoutInterval: 10)
        
        // completion Handler 방식 - task 다 끝나고 실행
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            DispatchQueue.main.async {
                if let error {
                    completionHandler(nil)
                    return
                }
                
                guard let response = response as? HTTPURLResponse,
                      (200...500).contains(response.statusCode) else {
                    print(error)  // Alert 또는 Do try Catch 등
                    completionHandler(nil)
                    return
                }
                
                guard let data else {
                    completionHandler(nil)
                    return
                }
            
                do {
                    let result = try JSONDecoder().decode(Photo.self, from: data)
                    print(result)
                    completionHandler(result)
                } catch {
                    completionHandler(nil)
                    print(error)  // 디코딩 오류 키 탐지 가능
                }
            }
            
        }.resume()
        
        // sessionDelegate 방식 - 최초 응답 / 중간과정 알 수 있음. ex_용량이 큰 이미지 다운로드 진행률
        //                       shared 세션 사용 불가능
    }
    
}

struct Photo: Codable {
    let total: Int
    let total_pages: Int
    let results: [PhotoResult]
}

struct PhotoResult: Codable {
    let id: String
    let urls: PhotoURL
}

struct PhotoURL: Codable {
    let full: String
    let thumb: String
}
