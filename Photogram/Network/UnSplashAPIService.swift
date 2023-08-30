//
//  UnSplashAPIService.swift
//  Photogram
//
//  Created by 장혜성 on 2023/08/30.
//

import Foundation
import Alamofire

class UnSplashAPIService {
    static let shared = UnSplashAPIService()
    private init() {}
    
    let header: HTTPHeaders = ["Authorization" : "Client-ID \(APIKey.unsplashKey)"]
    
    let url = "https://api.unsplash.com/search/photos"

    func call<T: Codable>(
        responseData: T.Type,
        parameterDic: [String:Any]? = nil,
        success: @escaping (_ response: T) -> (),
        failure: @escaping (_ error: String) -> Void,
        end: @escaping (_ endUrl: String) -> Void
    ){
        var parameters: Parameters = [:]
        if let parameterDic {
            parameterDic.forEach { (key, value) in
                parameters.updateValue(value, forKey: key)
            }
        }
        
        AF.request(url, method: .get, parameters: parameters, headers: header)
            .validate(statusCode: 200...500)
            .responseDecodable(of: T.self) { response in
                print(response.request?.url)
                print(response.request?.headers)
                print(response.response?.statusCode)
                var requestStatus: String
                switch response.result {
                case .success(let data):
                    print("data =", data)
                    success(data)
                    requestStatus = "성공"
                case .failure(let error):
                    print(error)
                    failure(error.errorDescription ?? "오류")
                    requestStatus = "실패"
                }
                end("======== \(self.url) ======== 호출 \(requestStatus)")
            }
    }
    
}
