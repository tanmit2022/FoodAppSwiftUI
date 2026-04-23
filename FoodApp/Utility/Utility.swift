//
//  Utility.swift
//  SampleApp
//
//  Created by Amit on 20/03/26.
//
import UIKit
import AVFoundation
import SwiftUICore

//let appDelegate = UIApplication.shared.delegate as! AppDelegate
let userDefaults: UserDefaults = UserDefaults.standard
let storyboardMain = UIStoryboard(name: "Main", bundle: nil)
let bundleIdentifier = Bundle.main.bundleIdentifier


//---**----Get Current Device Size----***--
struct ScreenSize{
    static let SCREEN_WIDTH = UIScreen.main.bounds.size.width;
    static let SCREEN_HEIGHT = UIScreen.main.bounds.size.height;
    static let SCREEN_MAX_LENGTH  = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT);
    static let SCREEN_MIN_LENGTH = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT);
}

struct DeviceType{
    static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6p = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPHONE_X_Xs = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 812.0
    static let IS_IPHONE_Xr_Xmax = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 896.0
    static let IS_IPAD = UIDevice.current.userInterfaceIdiom == .pad ? true : false
}

public extension String {
    func firstLetterC() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    mutating func capitalizeFirstLetter() {
        self = self.firstLetterC()
    }
    
    
    //start
    var floatValue: Float {
        return (self as NSString).floatValue
    }
    var intValue: Int {
        return (self as NSString).integerValue
    }
    var doubleValue: Double {
        return (self as NSString).doubleValue
    }
    var decimalValue: Decimal {
        return Decimal((self as NSString).doubleValue)
    }//end
 
}





extension UITextField {
    func setPlaceholderColor(_ color: UIColor) {
        self.attributedPlaceholder = NSAttributedString(
            string: self.placeholder ?? "",
            attributes: [.foregroundColor: color]
        )
    }
}


//Server time to local time
func UTCToLocal(date:String, format: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    //dateFormatter.locale = Locale.current
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.timeZone = TimeZone(abbreviation: "PDT")//PDT or UTC
    if let dt = dateFormatter.date(from: date) {
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: dt)
    }
    return ""
}
func localToUTC(date:String, format: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    dateFormatter.timeZone = TimeZone.current
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")

    if let dt = dateFormatter.date(from: date) {
        dateFormatter.timeZone = TimeZone(abbreviation: "PDT")
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: dt)
    }
    return ""
}
func changeDateFormat(from: String, to: String, strDate:String)-> String {
    if strDate != "" {
        let formatter = DateFormatter()
        formatter.dateFormat = from
        formatter.locale = Locale(identifier: "en_US_POSIX")

        guard let date = formatter.date(from: strDate) else {
            return ""
        }
        
        let formatter1 = DateFormatter()
        formatter1.dateFormat = to
        formatter1.locale = Locale(identifier: "en_US_POSIX")

        let gd = formatter1.string(from: date)
        return gd
    }
    return ""
}
func formattedNumber(number: String) -> String {
    let cleanPhoneNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    let mask = "(XXX) XXX XXXX"
    
    var result = ""
    var index = cleanPhoneNumber.startIndex
    for ch in mask where index < cleanPhoneNumber.endIndex {
        if ch == "X" {
            result.append(cleanPhoneNumber[index])
            index = cleanPhoneNumber.index(after: index)
        } else {
            result.append(ch)
        }
    }
    return result
}




//MARK: SwiftUI

extension Color {
   //MARK:
   init(hex: String) {
       let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
       var int: UInt64 = 0
       Scanner(string: hex).scanHexInt64(&int)
       
       let r, g, b, a: UInt64
       
       switch hex.count {
       case 3: // RGB (12-bit)
           (r, g, b, a) = (
               (int >> 8) * 17,
               (int >> 4 & 0xF) * 17,
               (int & 0xF) * 17,
               255
           )
           
       case 6: // RGB (24-bit)
           (r, g, b, a) = (
               int >> 16,
               int >> 8 & 0xFF,
               int & 0xFF,
               255
           )
           
       case 8: // ARGB (32-bit)
           (r, g, b, a) = (
               int >> 16 & 0xFF,
               int >> 8 & 0xFF,
               int & 0xFF,
               int >> 24
           )
           
       default:
           (r, g, b, a) = (1, 1, 1, 1)
       }
       
       self.init(
           .sRGB,
           red: Double(r) / 255,
           green: Double(g) / 255,
           blue: Double(b) / 255,
           opacity: Double(a) / 255
       )
   }
   
   
   
   //MARK:2
   init(rgbRed: Double, green: Double, blue: Double, opacity: Double = 255) {
       self.init(
           red: rgbRed / 255,
           green: green / 255,
           blue: blue / 255,
           opacity: opacity / 255
       )
   }
}

