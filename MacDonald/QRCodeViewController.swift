//
//  QRCodeViewController.swift
//  MacDonald
//
//  Created by IFTS09 on 04/03/23.
//

import UIKit

class QRCodeViewController: UIViewController {
    
    
    @IBOutlet weak var paninoLabel: UILabel!
    
    
    @IBOutlet weak var paninoImage: UIImageView!
    
    
    @IBOutlet weak var QRImage: UIImageView!
    
    var selectedMeal : Meal?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        QRImage.image = generateQRCode(from:"https://www.mcdonalds.it")
        
        paninoImage.image = selectedMeal?.mealImage
        paninoLabel.text = selectedMeal?.name

        // Do any additional setup after loading the view.
    }
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
          filter.setValue(data, forKey: "inputMessage")
          let transform = CGAffineTransform(scaleX: 10, y: 10)
          if let output = filter.outputImage?.transformed(by: transform) {
            return UIImage(ciImage: output)
          }
        }
        return nil
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
