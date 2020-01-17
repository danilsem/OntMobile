//
//  TimetableViewController.swift
//  OntMobile
//
//  Created by Admin on 25/12/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class TimetableViewController: UIViewController {

    @IBOutlet weak var dayPicker: UIPickerView!
    @IBOutlet weak var groupPicker: UIPickerView!
    @IBOutlet weak var showButton: UIButton!
    
    let days = ["Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота"]
    var groups: Array<String> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        showButton.layer.cornerRadius = 5
        
        dayPicker.delegate = self
        dayPicker.dataSource = self
        
        groupPicker.delegate = self
        groupPicker.dataSource = self
        
        let session = URLSession.shared.dataTask(with: URL(string: "http://api.ontvkr.ru/gruppa/")!) { [weak self]
            data, _, _ in
            guard let self = self else {return}
            
            var json: Dictionary<String, Any>?
            
            do {
                json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! Dictionary<String, Any>
            }
            catch {
                
            }
            
            let groupsJsonArray = json!["records"] as! Array<Dictionary<String, Any>>
            
            DispatchQueue.main.async {
                for group in groupsJsonArray {
                    self.groups.append(group["nomer"] as! String)
                }
                
                self.groupPicker.reloadAllComponents()
            }
        }
        
        session.resume()
        
        
    }
    
    @IBAction func showButtonTouch(_ sender: Any) {
        class Chang: TimetableDataProtocol {
            var day: String!
            
            var group: String!
        }
        
        let ch = Chang()
        ch.day = days[dayPicker.selectedRow(inComponent: 0)]
        ch.group = groups[groupPicker.selectedRow(inComponent: 0)]
        
        performSegue(withIdentifier: "timetableSegue", sender: ch)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "timetableSegue" {
            let ch = sender as! TimetableDataProtocol
            guard let vc = segue.destination as? TimetableShowViewController else {return}
            vc.dataProtocol = ch
        }
    }
    

}

extension TimetableViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 0: do {
            return self.days.count
            }
        case 1: do {
            return self.groups.count
            }
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 0: do {
            return self.days[row]
            }
        case 1: do {
            return self.groups[row]
            }
        default:
            return ""
        }
    }
}
