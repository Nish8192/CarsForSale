//
//  CarListTableVC.swift
//  CarsForSale
//
//  Created by Nishant Aggarwal on 8/29/17.
//  Copyright © 2017 Nishant Aggarwal. All rights reserved.
//

import UIKit

class CarListTableVC: UITableViewController {
    
    var cars: [Car] = [];
    
    @IBOutlet var CarList: UITableView!
    
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
        CarList.reloadData();
    }
    
    private func saveCar(car: Car){
        self.loadData();
        cars.append(car);
        NSKeyedArchiver.archiveRootObject(cars, toFile: filePath);
    }
    
    private func saveEdit(){
        NSKeyedArchiver.archiveRootObject(cars, toFile: filePath);
    }

    override func viewDidLoad() {
        super.viewDidLoad();
        self.loadData();

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.loadData();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (cars.count);
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "carCell", for: indexPath) as! CarTableViewCell;

        cell.carInfo.text = "\(cars[indexPath.row].Make) \(cars[indexPath.row].Model)";
        cell.carPrice.text = cars[indexPath.row].Price;
        
//        cell.layer.backgroundColor = UIColor.purple.cgColor;
//        cell.carPrice.textColor = UIColor.white;
//        cell.carInfo.textColor = UIColor.white;


        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showEditAlert(atIndex: indexPath.row)
    }
    
    private func showEditAlert(atIndex: Int){
    let alert = UIAlertController(title: "Edit Car", message: "Enter new vehicle information", preferredStyle: .alert)
        alert.addTextField { (textField) in textField.text = self.cars[atIndex].Make }
        alert.addTextField { (textField) in textField.text = self.cars[atIndex].Model }
        alert.addTextField { (textField) in textField.text = self.cars[atIndex].Price }
        alert.textFields![0].textAlignment = .center;
        alert.textFields![1].textAlignment = .center;
        alert.textFields![2].textAlignment = .center;
        alert.textFields![2].keyboardType = .numberPad;
        alert.textFields![2].addTarget(self, action: #selector(editCarPriceDidChange), for: .editingChanged)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (action) in
            self.cars[atIndex].Make = alert.textFields![0].text!;
            self.cars[atIndex].Model = alert.textFields![1].text!;
            self.cars[atIndex].Price = alert.textFields![2].text!;
            self.saveEdit();
            self.loadData();
        }))
        
            self.present(alert, animated: true, completion: nil)
    }
    
    func editCarPriceDidChange(_ textField: UITextField) {
        if let amount = textField.text?.currencyInputFormatting() {
            textField.text = amount;
        }
    }
    
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            cars.remove(at: indexPath.row);
            NSKeyedArchiver.archiveRootObject(cars, toFile: filePath);
            self.loadData();
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
