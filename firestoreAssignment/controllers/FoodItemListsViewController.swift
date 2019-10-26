//
//  ViewController.swift
//  firestoreAssignment
//
//  Created by Aung Ko Ko on 23/10/2019.
//  Copyright © 2019 Phone Zaw Myint. All rights reserved.
//

import UIKit
import FirebaseFirestore

class FoodItemListsViewController: UIViewController {

    @IBOutlet weak var foodItemListTableView: UITableView!
    @IBOutlet weak var ratingView: UIView!
    @IBOutlet weak var insertView: UIView!
    @IBOutlet weak var entreesView: UIView!
    @IBOutlet weak var mainsView: UIView!
    @IBOutlet weak var drinksView: UIView!
    @IBOutlet weak var dessertsView: UIView!
    @IBOutlet weak var lblEntrees: UILabel!
    @IBOutlet weak var lblMains: UILabel!
    @IBOutlet weak var lblDrinks: UILabel!
    @IBOutlet weak var lblDesserts: UILabel!
    
    var foodType: String!
    var foods: [FoodVO] = []
    var listener: ListenerRegistration!
    var DB_COLLECTION_PATH = "Entrees"
    var  query: Query? {
        didSet{
            if let listener = listener{
                listener.remove()
            }
        }
    }
    
    lazy var activityIndicator : UIActivityIndicatorView = {
        let ui = UIActivityIndicatorView()
        ui.translatesAutoresizingMaskIntoConstraints = false
        ui.startAnimating()
        ui.style = UIActivityIndicatorView.Style.whiteLarge
        return ui
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.query = baseQuery()
       foodItemListTableView.delegate = self
       foodItemListTableView.dataSource = self
       foodItemListTableView.register(UINib(nibName: String(describing: FoodItemTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: FoodItemTableViewCell.self))
        foodItemListTableView.rowHeight = 117
        foodItemListTableView.separatorStyle = .none
        
        ratingView.layer.cornerRadius = ratingView.frame.width / 2
        insertView.layer.cornerRadius = insertView.frame.width / 2
        entreesView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lblEntrees.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        entreesView.layer.cornerRadius = 20
        mainsView.layer.cornerRadius = 20
        drinksView.layer.cornerRadius = 20
        dessertsView.layer.cornerRadius = 20
        entreesView.tag = 1
        mainsView.tag = 2
        drinksView.tag = 3
        dessertsView.tag = 4
        insertView.tag = 5
        foodType = "Entrees"
        
        let subViews: [Any] = [entreesView,mainsView,drinksView,dessertsView,insertView]
        for v in subViews {
            self.addGesture(to:v)
        }
    }

    
    
    override func viewWillAppear(_ animated: Bool) {
       loadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.listener.remove()
    }
    
    func loadData(){
        self.view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0).isActive = true
        activityIndicator.startAnimating()
        
        self.listener = query?.addSnapshotListener({ (querySnapshot, err) in
            if let err = err {
                print(err.localizedDescription)
                return
            }
            
            let results = querySnapshot?.documents.map({ (document) -> FoodVO in
                print("Document",document.data())
                if let food = FoodVO(dictionary: document.data(), id: document.documentID){
                    return food
                } else{
                    fatalError()
                }
            })
            self.foods = results ?? []
            self.foodItemListTableView.reloadData()
            self.activityIndicator.stopAnimating()
        })
    }
    
    func baseQuery() -> Query {
        return Firestore.firestore().collection(DB_COLLECTION_PATH)
    }
    
    func addGesture(to: Any?){
        if let v = to as? UIView {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapped(_:)))
            v.addGestureRecognizer(tapGesture)
            v.isUserInteractionEnabled = true
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
    
    @objc func tapped(_ sender: UITapGestureRecognizer){
        switch sender.view?.tag {
        case 1:
            entreesView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            mainsView.backgroundColor = .clear
            drinksView.backgroundColor = .clear
            dessertsView.backgroundColor = .clear
            lblEntrees.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            lblMains.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            lblDrinks.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            lblDesserts.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            foodType = "Entrees"
            checkForTable()
            baseQuery()
            self.query = baseQuery()
            loadData()
            break
        case 2:
            entreesView.backgroundColor = .clear
            mainsView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            drinksView.backgroundColor = .clear
            dessertsView.backgroundColor = .clear
            lblEntrees.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            lblMains.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            lblDrinks.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            lblDesserts.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            foodType = "Mains"
            checkForTable()
            baseQuery()
            self.query = baseQuery()
            loadData()
            break
        case 3:
            entreesView.backgroundColor = .clear
            mainsView.backgroundColor = .clear
            drinksView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            dessertsView.backgroundColor = .clear
            lblEntrees.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            lblMains.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            lblDrinks.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            lblDesserts.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            foodType = "Drinks"
            checkForTable()
            baseQuery()
            self.query = baseQuery()
            loadData()
            break
        case 4:
            entreesView.backgroundColor = .clear
            mainsView.backgroundColor = .clear
            drinksView.backgroundColor = .clear
            dessertsView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            lblEntrees.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            lblMains.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            lblDrinks.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            lblDesserts.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            foodType = "Desserts"
            checkForTable()
            baseQuery()
            self.query = baseQuery()
            loadData()
            break
        case 5:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let insertVC = storyboard.instantiateViewController(withIdentifier: String(describing: FoodItemInsertViewController.self)) as! FoodItemInsertViewController
            insertVC.foodType = self.foodType
            self.present(insertVC, animated: true, completion: nil)
            break
        default:
            break
        }
        print("Self.FoodList",self.foods)
    }
}

extension FoodItemListsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FoodItemTableViewCell.self), for: indexPath) as! FoodItemTableViewCell
        cell.food = foods[indexPath.row]
        return cell
    }
    
    
}

extension FoodItemListsViewController: UITableViewDelegate{
    
}
