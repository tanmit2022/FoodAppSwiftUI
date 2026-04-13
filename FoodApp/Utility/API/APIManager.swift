//
//  APIManager.swift
//  SampleApp
//
//  Created by Amit on 20/03/26.
//

import Foundation
import Alamofire
import SwiftyJSON
import SVProgressHUD

enum NetworkError: Error {
    case failure
    case success
}


 

 class APIManager {
    
    static let shared = APIManager()
    let session: Session
    
    let interceptor = Interceptor(
        adapter: AuthAdapter(),
        retrier: AuthRetrier()
    )

    //let session = Session(interceptor: interceptor)
    
    private init() {
        session = Session(interceptor: interceptor)
    }
    
     
     func requestWithParams(isAuth: Bool = true,
         _ url: String,
         method: HTTPMethod = .post,
         parameters: Parameters? = nil,
         headers: HTTPHeaders? = nil,
         
         completion: @escaping (JSON,WSResponse?,NSError?) -> Void
     ) {
         
         let Auth = isAuth ? APIClient.shared.session : AF
         Auth.request(url,
                         method: method,
                         parameters: parameters,
                    encoding: JSONEncoding.default,
                         headers: headers)
         .validate()
         .responseData(completionHandler: { response in
             
             
             print("response code \(response.response?.statusCode)")
             
             switch response.result {
             case .success(let data):
                 let json = JSON(data)
                 print("json \(json)")
                 
                 let wsResponse = WSResponse(code: response.response?.statusCode ?? 200, success: json["success"].stringValue, message: json["message"].stringValue, jsonValue: json, isInternet: true)
                 completion(json,wsResponse,nil)
                
             case .failure(let error):
                 print("error \(error)")

                 if let data = response.data {
                     do {
                         let json = try JSON(data: data)
                         
                         print("error json:\(json)")

                         let wsResponse = WSResponse(code: response.response?.statusCode ?? 1009, success: "false", message: json["message"].stringValue, jsonValue: json, isInternet: true)
                         completion(json,wsResponse,error as NSError?)
                         
                     }catch {
                         let wsResponse = WSResponse(code: response.response?.statusCode ?? 1009, success: "false", message: error.localizedDescription, jsonValue: JSON.null, isInternet: true)
                         completion([],wsResponse,error as NSError?)
                     }
                 }else{
                     let wsResponse = WSResponse(code: response.response?.statusCode ?? 1009, success: "false", message: error.localizedDescription, jsonValue: JSON.null, isInternet: true)
                     completion([],wsResponse,error as NSError?)
                 }
             }
         })
     }
     
//     func request<T: Decodable, U: Encodable>(
//         _ url: String,
//         method: HTTPMethod = .post,
//         parameters: U? = nil,
//         encoder: ParameterEncoder = URLEncodedFormParameterEncoder.default,
//         headers: HTTPHeaders? = nil,
//         responseType: T.Type,
//         completion: @escaping (JSON,WSResponse?,NSError?) -> Void
//     ) {
//         
//         session.request(url,
//                         method: method,
//                         parameters: parameters,
//                         encoder: encoder,
//                         headers: headers)
//         .validate()
//         .responseDecodable(of: T.self) { response in
//             
//             switch response.result {
//             case .success(let data):
//                 let json = JSON(data)
//                 let wsResponse = WSResponse(code: response.response?.statusCode ?? 200, success: json["success"].stringValue, message: json["message"].stringValue, jsonValue: json, isInternet: true)
//                 completion(json,wsResponse,nil)
//                
//             case .failure(let error):
//                 let wsResponse = WSResponse(code: response.response?.statusCode ?? 1009, success: "false", message: error.localizedDescription, jsonValue: JSON.null, isInternet: true)
//                 completion([],wsResponse,error as NSError?)
//             }
//         }
//     }
}



class APIManager1: NSObject {
    
    static let shared : APIManager1 = APIManager1()
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    static func callwebserviceGetJWTToken(apiUrl: String, information: [String: String]? = nil, completion:@escaping (JSON,WSResponse,NSError?) -> Void){
        
        AF.request(apiUrl,method: .post,parameters: information).responseData { response in
            
            if response.response?.statusCode == 0 {
                callwebserviceGetJWTToken(apiUrl: apiUrl, information: information, completion: completion)
                
            }else{
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let wsResponse = WSResponse(code: response.response?.statusCode ?? 200, success: json["success"].stringValue, message: json["message"].stringValue, jsonValue: json, isInternet: true)
                    completion(json,wsResponse,nil)
                case .failure(let error):
                    let wsResponse = WSResponse(code: response.response?.statusCode ?? 1009, success: "false", message: error.localizedDescription, jsonValue: JSON.null, isInternet: true)
                    completion([],wsResponse,error as NSError?)
                }
            }
        }
    }
    
    static func callwebservicePostAPI(apiUrl: String, information: [String: String]? = nil, completion:@escaping (JSON,WSResponse?,NSError?) -> Void){
        
        print("apiUrl: \(apiUrl)")
        AF.request(apiUrl,method: .post,parameters: information)
           // .validate()
            .responseData { response in
            //print("response.response?.statusCode: \(response.response?.statusCode)")

            if response.response?.statusCode == 0 {
                callwebservicePostAPI(apiUrl: apiUrl, information: information, completion: completion)
                
            }else{
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let wsResponse = WSResponse(code: response.response?.statusCode ?? 200, success: json["success"].stringValue, message: json["message"].stringValue, jsonValue: json, isInternet: true)
                    completion(json,wsResponse,nil)
              
                case .failure(let error):
                    let wsResponse = WSResponse(code: response.response?.statusCode ?? 1009, success: "false", message: error.localizedDescription, jsonValue: JSON.null, isInternet: true)
                    completion([],wsResponse,error as NSError?)
                }
            }
        }
    }
    static func callwebserviceWithTokenPostAPI(apiUrl: String, information: [String: String]? = nil, completion:@escaping (JSON,WSResponse,NSError?) -> Void){
        
        print("apiUrl: \(apiUrl)")
        APIClient.shared.session.request(apiUrl,method: .post,parameters: information)
            .validate()
            .responseData { response in
                print("response.response?.statusCode: \(response.response?.statusCode)")

                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let wsResponse = WSResponse(code: response.response?.statusCode ?? 200, success: json["success"].stringValue, message: json["message"].stringValue, jsonValue: json, isInternet: true)
                    completion(json,wsResponse,nil)
              
                case .failure(let error):
                    let wsResponse = WSResponse(code: response.response?.statusCode ?? 1009, success: "false", message: error.localizedDescription, jsonValue: JSON.null, isInternet: true)
                    completion([],wsResponse,error as NSError?)
                }
        }
    }
}



