//
//  TaxViewController.swift
//  TaxApp
//
//  Created by 宮越大輝 on 2021/11/08.
//

import UIKit

class TaxViewController: UIViewController {
    
    @IBOutlet weak var displatPriceLbel: UILabel!
    @IBOutlet weak var priceTableView: UITableView!
    @IBOutlet weak var textFiled: UITextField!
    
    var inputPrice: Float = 0
    var selectedTax: Float = 1.1
    var priceArray: [String] = []
    var totalPrice: Float = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        priceTableView.dataSource = self
        textFiled.keyboardType = UIKeyboardType.numberPad //textfiledには数字(Int)のみ入力可能
        displatPriceLbel.text = ""
    }
    
    @IBAction func selectTaxSegment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            selectedTax = 1.08
        } else if sender.selectedSegmentIndex == 1 {
            selectedTax = 1.1
        } else {
            // none
        }
        showPrice()
    }
    
    @IBAction func addButton(_ sender: Any) {
        if textFiled.text != nil && inputPrice != 0 {
            priceArray.append("\(inputPrice * selectedTax)") //cellに入れるためにString型
            totalPrice += inputPrice * selectedTax //Floatにキャストを削除
            initPrice()
            
            let userDefault = UserDefaults.standard
            userDefault.set(totalPrice, forKey: "sum")
        } else {
            // none
        }
        
        priceTableView.reloadData()
    }
    
    @IBAction func changePrice(_ sender: UITextField) {
        showPrice()
    }
    
    func showPrice() {
        if textFiled.text != nil {
            inputPrice = textFiled.textToFloat //extensionのtextToFloatでFloat型に変換しています
            
            displatPriceLbel.text = "\(inputPrice * selectedTax)" //Floatにキャストを削除
        } else {            inputPrice = 0
        }
    }
    
    func initPrice() {
        displatPriceLbel.text = ""
        textFiled.text = ""
        inputPrice = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //この画面に戻ってきたら値は初期化していく
        initPrice()
        priceArray = []
        totalPrice = 0
        let userDefault = UserDefaults.standard
        userDefault.set(totalPrice, forKey: "sum")
        priceTableView.reloadData()
    }
}

extension UITextField {
    var textToFloat: Float { //ToFloatに変更
        let text = self.text
        let float = text
            .flatMap{Float($0)} ?? 0
        return float
    }
}

extension TaxViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return priceArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PriceCell", for: indexPath)
        
        cell.textLabel?.text = priceArray[indexPath.row]
        
        return cell
    }
}
