//
//  NewCarVC.swift
//  CarsForSale
//
//  Created by Nishant Aggarwal on 8/29/17.
//  Copyright © 2017 Nishant Aggarwal. All rights reserved.
//

import UIKit

class NewCarVC: UIViewController {

    @IBOutlet weak var newCarMake: UITextField!
    
    
    @IBOutlet weak var newCarPrice: UITextField!
    
    
    @IBOutlet weak var newCarModel: UITextField!
    
    var cars: [Car] = [];
    
    var filePath: String {
        let manager = FileManager.default;
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first;
        return url!.appendingPathComponent("CarList").path
    }
    
    private func loadData() {
        if let savedCars = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? [Car] {
            cars = savedCars;
            print (cars);
        }
    }
    
    
    
    private func saveCar(car: Car){
        self.loadData();
        cars.append(car);
        NSKeyedArchiver.archiveRootObject(cars, toFile: filePath);
    }
    
    @IBAction func saveNewCar(_ sender: Any) {
        if(newCarMake.text != "") {
            if(newCarModel.text != "") {
                if(newCarPrice.text != "") {
                    let newCar = Car(make: newCarMake.text!, model: newCarModel.text!, price: newCarPrice.text!);
                    self.saveCar(car: newCar);
                    self.navigationController!.popViewController(animated: true);
                } else {
                    showNoPriceAlert();
                }
            } else {
                showNoModelAlert();
            }
        } else {
            showNoMakeAlert();
        }
        
    }
    
    func showNoMakeAlert(){
        let alert = UIAlertController(title: "ERROR", message: "Please enter a make!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showNoModelAlert(){
        let alert = UIAlertController(title: "ERROR", message: "Please enter a model!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showNoPriceAlert(){
        let alert = UIAlertController(title: "ERROR", message: "Please enter a price!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.newCarPrice.keyboardType = .numberPad;
        self.newCarPrice.addTarget(self, action: #selector(newCarPriceDidChange), for: .editingChanged)
    }
    
    func newCarPriceDidChange(_ textField: UITextField) {
        if let amount = textField.text?.currencyInputFormatting() {
            textField.text = amount;
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension String {
    func currencyInputFormatting() -> String {
        
        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = "$"
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        var amountWithPrefix = self
        
        // remove from String: "$", ".", ","
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count), withTemplate: "")
        
        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double / 100))
        
        // if first number is 0 or all numbers were deleted
        guard number != 0 as NSNumber else {
            return ""
        }
        
        return formatter.string(from: number)!
    }
}
