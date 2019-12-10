//
//  SecondViewController.swift
//  OntMobile
//
//  Created by Admin on 20/11/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var groupPicker: UIPickerView!
    var groups: Array<String> = [] //= ["ПКС-10", "ИСП-1", "ИСП-2"]
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        groupPicker.dataSource = self
        groupPicker.delegate = self
        
        let session = URLSession.shared.dataTask(with: URL(string: "http://api.ontvkr.ru/gruppa/")!, completionHandler: { [weak self]
            data, _, error in
            guard let self = self else {return}
            
            var json: Dictionary<String, Any>?
            
            do {
                json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? Dictionary<String, Any>
            }
            catch {
                
            }
            
            let groupsArray = json?["records"] as! Array<Dictionary<String, Any>>
            
            DispatchQueue.main.async {
                for group in groupsArray {
                    self.groups.append(group["nomer"] as! String)
                    self.groupPicker.reloadAllComponents()
                }
            }
            
            //print(json?["records"] as! Array<Dictionary<String, Any>>)
            
        })
        
        session.resume()
    }

    @IBAction func showChanges(_ sender: Any) {
        class Chang: ChangesProtocol {
            var date: Date!
            
            var groupName: String!
        }
        let ch = Chang()
        ch.date = datePicker.date
        ch.groupName = groups[groupPicker.selectedRow(inComponent: 0)]
            
        performSegue(withIdentifier: "changesIdendifier", sender: ch)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "changesIdendifier" {
            let date = sender as! ChangesProtocol
            guard let vc = segue.destination as? ChangesViewController else {return}
            //vc.date = date
            
            vc.changesProtocol = date
        }
    }
}

extension SecondViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return groups.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return groups[row]
    }
}

