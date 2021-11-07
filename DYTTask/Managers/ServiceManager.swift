//
//  ServiceManager.swift
//  DYTTask
//
//  Created by apple on 03/11/21.
//

import Foundation
import UIKit
import Reachability
import Alamofire

enum ApiError: Error {
    
    case technicalError
    case noError
    
    var label: String {
        switch self {
       
        case .technicalError:
            return "Something Went Wrong! Our system may be having some trouble, Please try again later. We apologize for the inconvenience."
        
        case .noError:
            return ""
        }
    }
}


class ServiceManager {
    
    static var shared = ServiceManager()
   
    func uploadPhoto(_ url: String, image: UIImage, params: [String : Any],completionHandler: @escaping (String, ApiError,Float) -> ()) {
    let urlwithPercentEscapes = url.addingPercentEncoding( withAllowedCharacters: CharacterSet.urlQueryAllowed)
    // let httpHeaders = HTTPHeaders(header)
        GlobalVariables.shared.request = AF.upload(multipartFormData: { multiPart in
         for p in params {
             multiPart.append("\(p.value)".data(using: String.Encoding.utf8)!, withName: p.key)
         }
        multiPart.append(image.jpegData(compressionQuality: 0.9)!, withName: "file", fileName: "file", mimeType: "image/jpg")
     }, to: urlwithPercentEscapes!, method: .post) .uploadProgress(queue: .main, closure: { progress in
         print("Upload Progress: \(progress.fractionCompleted)")
         completionHandler("",.noError,Float(progress.fractionCompleted))
     }).responseJSON(completionHandler: { data in
         print("upload finished: \(data)")
         completionHandler("success",.noError,1)
     }).response { (response) in
         switch response.result {
         case .success(let resut):
             print("upload success result: \(resut)")
             
         case .failure(let err):
             print("upload err: \(err)")
             completionHandler("",.technicalError,0)
         }
     }

  }
   
}
