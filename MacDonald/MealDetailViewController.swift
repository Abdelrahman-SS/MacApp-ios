//
//  MealDetailViewController.swift
//  MacDonald
//
//  Created by IFTS09 on 04/03/23.
//

import UIKit

class MealDetailViewController: UIViewController {
    
    @IBOutlet weak var mealDetailImage: UIImageView!
    
    @IBOutlet weak var descTextView: UITextView!
    
    @IBAction func UtilizzaButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "Attention", message: "Are you sure you want to use QRCode?", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        let confirm = UIAlertAction(title: "Confirm", style: .default) { confirmBT in
            self.performSegue(withIdentifier: "toQR", sender: nil)
        }
        alert.addAction(cancel)
        alert.addAction(confirm)
        present(alert,animated: true)
        
    }
    
    
    @IBOutlet weak var titleLable: UILabel!
    
    var recivedMeal : Meal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descTextView.text = recivedMeal?.desc
        mealDetailImage.image = recivedMeal?.mealImage
        mealDetailImage.layer.cornerRadius = 35
        mealDetailImage.layer.borderColor = UIColor.black.cgColor
        mealDetailImage.layer.borderWidth = 1.0

        titleLable.text = recivedMeal?.name
        
        

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let VC = segue.destination as! QRCodeViewController
        VC.selectedMeal = recivedMeal
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
