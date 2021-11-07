//
//  IUViewController.swift
//  DYTTask
//
//  Created by apple on 03/11/21.
//

import Foundation
import UIKit
import Alamofire
import MBProgressHUD
extension UIViewController{
    
    func showAlert(title: String, message: String, callback: @escaping () -> ()) {
        DispatchQueue.main.async {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {
            alertAction in
            callback()
        }))
        self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    
func openGalleryAlert(callback: @escaping (String) -> ()){
    let alert = UIAlertController(title: "Choose Image From", message: nil, preferredStyle: .actionSheet)
    let cameraAction = UIAlertAction(title: "Camera", style: .default){
        UIAlertAction in
        callback("Camera")
    }
    let galleryAction = UIAlertAction(title: "Gallery", style: .default){
        UIAlertAction in
        callback("Gallery")
    }
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){
        UIAlertAction in
    }
    
    alert.addAction(cameraAction)
    alert.addAction(galleryAction)
    alert.addAction(cancelAction)
    self.present(alert, animated: true, completion: nil)
  }
}



class GlobalVariables {
    static var shared = GlobalVariables()
    var request : Alamofire.Request?
}
extension UIColor {
    
    static let primary: UIColor = #colorLiteral(red: 0, green: 0.7342305183, blue: 0.8382151723, alpha: 1)
}
