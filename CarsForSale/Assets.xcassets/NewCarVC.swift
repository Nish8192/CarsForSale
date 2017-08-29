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

        // Do any additional setup after loading the view.
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
