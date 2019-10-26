//
//  FoodItemInsertViewController.swift
//  firestoreAssignment
//
//  Created by Aung Ko Ko on 25/10/2019.
//  Copyright © 2019 Phone Zaw Myint. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore

class FoodItemInsertViewController: UIViewController {
    @IBOutlet weak var ivFoodItem: UIImageView!
    @IBOutlet weak var btnChooseAndUploadImage: UIButton!
    @IBOutlet weak var txtAmount: UITextField!
    @IBOutlet weak var txtFoodName: UITextField!
    @IBOutlet weak var txtRating: UITextField!
    @IBOutlet weak var txtWaitingIssues: UITextField!
    @IBOutlet weak var btnCreate: UIButton!
    
    var foodType:String!
    var DB_COLLECTION_PATH = ""
    var imageReference: StorageReference!
    
    lazy var activityIndicator : UIActivityIndicatorView = {
        let ui = UIActivityIndicatorView()
        ui.translatesAutoresizingMaskIntoConstraints = false
        ui.startAnimating()
        ui.style = UIActivityIndicatorView.Style.whiteLarge
        return ui
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageName = UUID().uuidString
        imageReference = Storage.storage().reference().child("images").child(imageName)
        print("Fodd ",foodType)
        checkForTable()
    }
    
    @IBAction func btnChooseAndUploadImage(_ sender: Any) {
        ImagePickerManager().pickImage(self) { (image) in
            self.ivFoodItem.image = image
        }
    }
    @IBAction func btnCreate(_ sender: Any) {
        self.view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0).isActive = true
        activityIndicator.startAnimating()
        
        guard let image = self.ivFoodItem.image, let data = image.jpegData(compressionQuality: 0.8) else {
            return
        }
        imageReference.putData(data, metadata: nil) { (metadata, err) in
            if let err = err {
                print(err.localizedDescription)
                return
            }
            self.imageReference.downloadURL { (url, err) in
                if let err = err {
                    print(err.localizedDescription)
                    return
                }
                print("URL",url)
                if let url = url {
                    let db = Firestore.firestore()
                    db.collection(self.DB_COLLECTION_PATH).addDocument(data: ["amount":self.txtAmount.text ?? "" ,
                         "food_name": self.txtFoodName.text ?? "",
                         "rating" : self.txtRating.text ?? "",
                         "waiting_time": self.txtWaitingIssues.text ?? "",
                         "imageUrl": url.absoluteString])
                     self.activityIndicator.stopAnimating()
                }
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func checkForTable(){
        switch foodType {
        case "Entrees":
            self.DB_COLLECTION_PATH = "Entrees"
            break
        case "Mains":
             self.DB_COLLECTION_PATH = "Mains"
            break
        case "Drinks":
             self.DB_COLLECTION_PATH = "Drinks"
            break
        case "Desserts":
             self.DB_COLLECTION_PATH = "Desserts"
            break
        default:
            break
        }
    }
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
