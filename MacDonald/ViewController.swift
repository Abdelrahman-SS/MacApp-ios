//
//  ViewController.swift
//  MacDonald
//
//  Created by IFTS09 on 04/03/23.
//

import UIKit

class ViewController: UIViewController,UISearchBarDelegate ,UICollectionViewDelegate , UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    
    var margin : CGFloat = 20
    var filteredArray : [Meal] = []
    var refresher = UIRefreshControl()
    var search : Bool = false
    @IBOutlet weak var myCollection: UICollectionView!
    
    var mealsArray : [Meal] = [Meal(name: "Big Mac", ingridents: "Burger , Smoked Cheese , Tomato , Onion , Katchup", mealImage: UIImage(named: "menu_bbq")!, desc: "There are 550 calories in a Big Mac® from McDonald's. Pair it with any of our beverages or grab a Big Mac® Combo Meal with our World Famous Fries® and Coca-Cola® or any of your favorite fountain drinks. Order a Big Mac® today using the McDonald's app to Mobile Order & Pay*! Download the McDonald’s app and earn points on eligible orders with MyMcDonald's Rewards to redeem for a free Big Mac®."),Meal(name: "MacChiken", ingridents: "Fried Chiken  Mac Souce , Onion , Lettuce", mealImage: UIImage(named: "menu_mcchicken")!, desc: "There are 550 calories in a Big Mac® from McDonald's. Pair it with any of our beverages or grab a Big Mac® Combo Meal with our World Famous Fries® and Coca-Cola® or any of your favorite fountain drinks. Order a Big Mac® today using the McDonald's app to Mobile Order & Pay*! Download the McDonald’s app and earn points on eligible orders with MyMcDonald's Rewards to redeem for a free Big Mac®."),Meal(name: "Mac Cheese", ingridents: "Burger , Double Cheese ,Onion , KatchUp , Tomato", mealImage: UIImage(named: "menu_hero_meta" )!, desc: "There are 550 calories in a Big Mac® from McDonald's. Pair it with any of our beverages or grab a Big Mac® Combo Meal with our World Famous Fries® and Coca-Cola® or any of your favorite fountain drinks. Order a Big Mac® today using the McDonald's app to Mobile Order & Pay*! Download the McDonald’s app and earn points on eligible orders with MyMcDonald's Rewards to redeem for a free Big Mac®.",qrCode: UIImage(named: "qr_code")!)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myCollection.delegate = self
        myCollection.dataSource = self
        
        // Do any additional setup after loading the view.
        let collectionView = myCollection
        let flowLayout = collectionView?.collectionViewLayout as?
        UICollectionViewFlowLayout
        
        flowLayout?.minimumInteritemSpacing = margin
        flowLayout?.minimumLineSpacing = margin
        flowLayout!.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        myCollection.addSubview(refresher)

        refresher.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)

        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        if search{
            return filteredArray.count
        }else{
            return mealsArray.count
        }
        
    }
    @objc func refreshData(_ refresher: UIRefreshControl) {
            
        mealsArray.append(Meal(name: "Mac BBQ", ingridents: "Burger , BBQ , Tomato , Katchup", mealImage: UIImage(named: "menu_bbq")!, desc: "There are 550 calories in a Big Mac® from McDonald's. Pair it with any of our beverages or grab a Big Mac® Combo Meal with our World Famous Fries® and Coca-Cola® or any of your favorite fountain drinks. Order a Big Mac® today using the McDonald's app to Mobile Order & Pay*! Download the McDonald’s app and earn points on eligible orders with MyMcDonald's Rewards to redeem for a free Big Mac®."))
        mealsArray.append(Meal(name: "Mac BBQ X-LARGE", ingridents: "Burger , BBQ , Tomato , Katchup", mealImage: UIImage(named: "menu_bbq")!, desc: "There are 550 calories in a Big Mac® from McDonald's. Pair it with any of our beverages or grab a Big Mac® Combo Meal with our World Famous Fries® and Coca-Cola® or any of your favorite fountain drinks. Order a Big Mac® today using the McDonald's app to Mobile Order & Pay*! Download the McDonald’s app and earn points on eligible orders with MyMcDonald's Rewards to redeem for a free Big Mac®."))
        myCollection.reloadData()
        refresher.endRefreshing()
        }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MealsCollectionViewCell
        cell.myMealImage.image = mealsArray[indexPath.row].mealImage
        cell.mealNameLabel.text = mealsArray[indexPath.row].name
        cell.descLabel.text = mealsArray[indexPath.row].ingridents
        cell.layer.cornerRadius = 20
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 3.0
        
        cell.myMealImage.layer.cornerRadius = 20
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let noOfCells = 2
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left + flowLayout.sectionInset.right + (CGFloat(noOfCells) * flowLayout.minimumInteritemSpacing)
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCells))
        return CGSize(width: 160   , height: 300
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailController") as? MealDetailViewController
        
        self.navigationController?.pushViewController(detailVC ?? UIViewController(), animated: true)
        
        let aMeal = mealsArray[indexPath.row]
        
        detailVC?.recivedMeal = aMeal
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredArray = mealsArray.filter({ $0.name.lowercased().hasPrefix(searchText.lowercased())})
        myCollection.reloadData()
        
        if searchText.isEmpty{
            search = false
        }else{
            search = true
        }
 
        
    }
    
}
