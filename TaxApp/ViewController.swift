//
//  ViewController.swift
//  TaxApp
//
//  Created by 宮越大輝 on 2021/11/08.
//

import UIKit

class ViewController: UIViewController {
    
    var sumPrice: Float = 0 //floatに変更

    @IBOutlet weak var displayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userDefault = UserDefaults.standard
        
        if userDefault.object(forKey: "sum") != nil {
            sumPrice = userDefault.object(forKey: "sum") as! Float //as! Floatに変更
        }
        displayLabel.text = "\(Int(sumPrice))" //Intに変えて表示
    }

//    self.navigationController?.popViewController(animated: true)
}

