//
//  AuthInterceptor.swift
//  Utzo
//
//  Created by Amit on 25/03/26.
//  Copyright © 2026 Mac. All rights reserved.
//



//print("AuthAdapter: RequestAdapter TokenStorage.validExpiryDate:\(TokenStorage.validExpiryDate())")


 

import Alamofire
import SwiftyJSON
import Foundation

final class AuthAdapter: RequestAdapter {

    func adapt(_ urlRequest: URLRequest,
                for session: Session,
                completion: @escaping (Result<URLRequest, Error>) -> Void) {
         var request = urlRequest
        print("AuthAdapter: RequestAdapter TokenStorage.validExpiryDate:\(TokenStorage.validExpiryDate())")
         if let token = TokenStorage.accessToken {
             request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
         }
         
         completion(.success(request))
     }
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var request = urlRequest
        if let token = TokenStorage.accessToken {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        return request
    }
}


final class AuthRetrier: RequestRetrier, @unchecked Sendable {

    private var isRefreshing = false
    private var requestsToRetry: [(RetryResult) -> Void] = []
    private let lock = NSLock()
    
    func retry(_ request: Request,
               for session: Session,
               dueTo error: Error,
               completion: @escaping (RetryResult) -> Void) {
       // print("request.request?.url?.absoluteString: \(request.request?.url?.absoluteString)")

//        if request.request?.url?.absoluteString.contains("refreshToken") == true {//refresh_token
//            completion(.doNotRetry)
//            return
//        }
        guard let response = request.task?.response as? HTTPURLResponse,
              response.statusCode == 401 else {
            completion(.doNotRetry)
            return
        }
        
        lock.lock()
        requestsToRetry.append(completion)
        lock.unlock()

        refreshIfNeeded()
    }
    
    private func refreshIfNeeded() {
        lock.lock()
        let shouldRefresh = !isRefreshing
        isRefreshing = true
        lock.unlock()
        
        guard shouldRefresh else { return }
        
        refreshToken { success in
            self.lock.lock()
            let completions = self.requestsToRetry
            self.requestsToRetry.removeAll()
            self.isRefreshing = false
            self.lock.unlock()
            
            completions.forEach {
                $0(success ? .retry : .doNotRetry)
            }
        }
    }
}
private func refreshToken(completion: @escaping (Bool) -> Void) {
    guard let refreshToken = TokenStorage.refreshToken else {
        completion(false)
        return
    }

    let session = Session.default // 🚫 no interceptor
    let url = NetWorkingConstants.auth.refreshToken
    let parameters: [String: Any] = ["refresh": refreshToken]
    //print("parameters: \(parameters)")

    session.request(url,
                    method: .post,
                    parameters: parameters)
        .validate() // ✅ IMPORTANT
        .responseData { response in
//            print("🔍 Response Debug:")
//            print("Request:", response.request ?? "nil")
//            //print("Response:", response.response ?? "nil")
//            print("Error:", response.error ?? "nil")
//            print("Data:", String(data: response.data ?? Data(), encoding: .utf8) ?? "nil")
//            print("response.response?.statusCode: \(response.response?.statusCode)")
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
//                print("json refreshToken 401: \(json)")
                let userData = json["user_data"].dictionaryValue
                let refresh_token = userData["refresh"]?.stringValue
                let token = userData["access"]?.stringValue
                let expiresIn = userData["token_expires_in"]?.doubleValue ?? 0.0

                TokenStorage.accessToken = token
                TokenStorage.refreshToken = refresh_token
                TokenStorage.expiryDate = "\(Date().addingTimeInterval(expiresIn).timeIntervalSince1970)"

                completion(true)
                
            case .failure(let error):
                completion(false)
            }
        }
}



class APIClient {
    static let shared = APIClient()
    var session: Session
    
    let interceptor = Interceptor(
        adapter: AuthAdapter(),
        retrier: AuthRetrier()
    )

    //let session = Session(interceptor: interceptor)
    
    private init() {
        session = Session(interceptor: interceptor)
    }
 

    func recreateSession() {
        let configuration = URLSessionConfiguration.default
        self.session = Session(configuration: configuration,
                               interceptor: interceptor)
    }
}
