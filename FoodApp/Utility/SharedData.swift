//
//  SharedData.swift
//  SampleApp
//
//  Created by Amit on 20/03/26.
//
import Foundation
import UIKit

class SharedData:NSObject {
    static let singleton : SharedData = SharedData()

    
    func showAlertViewController(viewController:UIViewController,alertMessage:String) {
        let alertView = UIAlertController(title: "", message: alertMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: { (alert) in })
        alertView.addAction(action)
        alertView.view.tintColor = .black
        viewController.present(alertView, animated: true, completion: nil)
    }


    func showAlertViewController(viewController:UIViewController,alertMessage:String, completionHandler: @escaping (_ isBool: Bool)-> Void ) {
        DispatchQueue.main.async {
            
            let alertView = UIAlertController(title: "", message: alertMessage, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                completionHandler(true)
            })
            alertView.addAction(action)
            alertView.view.tintColor = .black
            
            viewController.present(alertView, animated: true, completion: nil)
        }
    }

    
    
    
    
    
    
    
}
