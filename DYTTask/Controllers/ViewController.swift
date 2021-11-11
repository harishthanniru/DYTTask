//
//  ViewController.swift
//  DYTTask
//
//  Created by apple on 03/11/21.
//

import UIKit
import Alamofire
class ViewController: UIViewController {

    
    @IBOutlet private var imgView:UIImageView!
    @IBOutlet private var galleryBtn:UIButton!
    @IBOutlet private var progressView:CircularPrgressBar!
    
    let imagePicker = UIImagePickerController()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.imgView.image = UIImage(named: "img")
        self.progressView.isHidden = true
        configureUI()
        NotificationCenter.default.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
       NotificationCenter.default.addObserver(self, selector: #selector(appMovedToForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }

    
    
    @IBAction private func openGallery(_ sender:UIButton){
        uploadFile(img: self.imgView.image!)
//        self.openGalleryAlert { (strng) in
//            if strng == "Camera"{
//                self.imagePicker.delegate = self
//                self.imagePicker.sourceType = .camera
//                self.imagePicker.allowsEditing = true
//                self.imagePicker.modalPresentationStyle = .fullScreen
//                self.present(self.imagePicker, animated: true, completion: nil)
//            }else{
//                self.imagePicker.delegate = self
//                self.imagePicker.sourceType = .photoLibrary
//                self.imagePicker.allowsEditing = true
//                self.imagePicker.modalPresentationStyle = .fullScreen
//                self.present(self.imagePicker, animated: true, completion: nil)
//            }
//        }
    }
    @objc func appMovedToBackground(){
        print("backgroundMode")
        GlobalVariables.shared.request?.suspend()
    }
    @objc func appMovedToForeground(){
        if GlobalVariables.shared.request != nil{
            GlobalVariables.shared.request?.resume()
        }
        print("Foreground")

    }
    
    
    private func configureUI(){
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = imgView.frame.size.width / 2
        galleryBtn.clipsToBounds = true
        galleryBtn.layer.cornerRadius = 4
    }
    
    
    private func uploadFile(img:UIImage){
        guard let path = Bundle.main.path(forResource: "video1", ofType:"mp4") else {
            return
        }
        let data = path.data(using: .utf8)
        print("dataaaaa",data)
        ServiceManager.shared.uploadVideo("https://k11api.fansedge.in/backOffice/upload/", video: data!, params: [:]) { data, error, progress in
            switch error {
            case .technicalError:
                self.showAlert(title: "Oops", message: error.label) {}
            case .noError:
                print("UploadProgressinn VCccc",progress)
                self.progressView.isHidden = false
                self.progressView.progress = progress
                if progress == 1{
                    self.progressView.isHidden = true
                }
            }
        }
    }
    
}

//MARK: - UIImagePickerControllerDelegate Methods
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            print("imagepickerImage",pickedImage)
            imgView.image = pickedImage
            uploadFile(img: pickedImage)
        }
        dismiss(animated: true, completion: nil)
    }
}
