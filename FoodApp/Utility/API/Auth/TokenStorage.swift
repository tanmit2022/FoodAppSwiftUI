//
//  TokenManager.swift
//  Utzo
//
//  Created by Amit on 25/03/26.
//  Copyright © 2026 Mac. All rights reserved.
//
import Foundation
import Alamofire

class TokenStorage {

    // MARK: - Keys
    private static let accessTokenKey = "accessToken"
    private static let refreshTokenKey = "refreshToken"
    private static let expiryDateKey = "expiryDate"

    // MARK: - Save
    static func saveToken(_ token: String, for key: String) {
        
        guard let data = token.data(using: .utf8) else { return }
        
        let query: [String: Any] = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key,
            kSecValueData as String   : data
        ]
        
        SecItemDelete(query as CFDictionary) // remove old value
        SecItemAdd(query as CFDictionary, nil)
    }
    
    // MARK: - Load
    static func loadToken(for key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key,
            kSecReturnData as String  : kCFBooleanTrue!,
            kSecMatchLimit as String  : kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        if status == errSecSuccess,
           let data = dataTypeRef as? Data,
           let token = String(data: data, encoding: .utf8) {
            return token
        }
        return nil
    }
    
    // MARK: - Delete
    static func deleteToken(for key: String) {
        let query: [String: Any] = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key
        ]
        SecItemDelete(query as CFDictionary)
    }
    
    // MARK: - Convenience
    static var accessToken: String? {
        get { loadToken(for: accessTokenKey) }
        set {
            if let token = newValue {
                saveToken(token, for: accessTokenKey)
            } else {
                deleteToken(for: accessTokenKey)
            }
        }
    }
    
    static var refreshToken: String? {
        get { loadToken(for: refreshTokenKey) }
        set {
            if let token = newValue {
                saveToken(token, for: refreshTokenKey)
            } else {
                deleteToken(for: refreshTokenKey)
            }
        }
    }
    static var expiryDate: String? {//Valid future date in timestamp
        get { loadToken(for: expiryDateKey) }
        set {
            if let token = newValue {
                saveToken(token, for: expiryDateKey)
            } else {
                deleteToken(for: expiryDateKey)
            }
        }
    }
    
    static func validExpiryDate()->Bool{
        let timestamp: TimeInterval = expiryDate?.doubleValue ?? 0.0 - 20.0
        let date = Date(timeIntervalSince1970: timestamp)
        let today = Date()
        print("\n\n**************************************************")
        print("accessToken: \(accessToken)")
        print("refreshToken: \(refreshToken)")
        print("timestamp: \(timestamp)")
        print("date: \(date)")
        print("today: \(today)     \(today < date)")
        print("**************************************************\n\n")

        
        if today < date {
            return true
        }else{
            return false
        }
    }
}
