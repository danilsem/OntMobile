//
//  ChangesViewController.swift
//  OntMobile
//
//  Created by Admin on 29/11/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

protocol ChangesProtocol {
    var date: Date! {get set}
    var groupName: String! {get set}
}

class Changes {
    var id: String!
    var cabinet: String!
    var prichina: String!
    var teacher_kto: String!
    var para: String!
}

class ChangesViewController: UIViewController {

    @IBOutlet weak var dateText: UILabel!
    
    @IBOutlet weak var firstLesson: UILabel!
    @IBOutlet weak var secondPara: UILabel!
    @IBOutlet weak var thirdPara: UILabel!
    @IBOutlet weak var fourLesson: UILabel!
    @IBOutlet weak var fiveLesson: UILabel!
    @IBOutlet weak var sixLesson: UILabel!
    @IBOutlet weak var sevenLesson: UILabel!
    
    var date: Date?
    var groupName: String?
    
    var changesProtocol: ChangesProtocol!
    
    var changes: Array<Changes> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dateFormated = DateFormatter()
        dateFormated.dateStyle = .medium
        dateFormated.timeStyle = .none
        dateFormated.locale = Locale(identifier: "ru_RU")
        
        dateText.text = dateFormated.string(from: changesProtocol.date!)
        
        dateFormated.dateFormat = "yyyy-MM-dd"
        
        let groupName = changesProtocol.groupName!
        
        var url = "http://api.ontvkr.ru/izmenenia/search.php?s=\(dateFormated.string(from: changesProtocol.date!))&&p=\(changesProtocol.groupName!)"
        
        self.firstLesson.text = "-----"
        self.secondPara.text = "-----"
        
        url = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let session = URLSession.shared.dataTask(with: URL(string: url)!) { data, _, _ in
            
            var json: Dictionary<String, Any>!
            
            do {
                json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? Dictionary<String, Any>
            } catch {
                
            }
            
            let changesArray = json["records"] as? Array<Dictionary<String, Any>>
            
            DispatchQueue.main.async {
                self.firstLesson.text = "-----"
                self.secondPara.text = "-----"
            }
            
            if changesArray != nil {
                DispatchQueue.main.async {
                    for change in changesArray! {
                        // MARK: Wrong way :)
                        let ch = Changes()
                        ch.id = change["id"] as! String
                        ch.cabinet = change["kabinet"] as! String
                        ch.prichina = change["prichina"] as! String
                        ch.teacher_kto = change["teacher_kto"] as! String
                        ch.para = change["para"] as! String
                        
                        self.changes.append(ch)
                    }
                    
                    for change in self.changes {
                        
                        if change.para.contains("1") {
                            self.firstLesson.text = "\(change.prichina!) Каб. \(change.cabinet!)"
                        }
                        else if change.para.contains("2") {
                            self.secondPara.text = "\(change.prichina!) Каб. \(change.cabinet!)"
                        }
                        else if change.para.contains("3") {
                            self.thirdPara.text = "\(change.prichina!) Каб. \(change.cabinet!)"
                        }
                        else if change.para.contains("4") {
                            self.fourLesson.text = "\(change.prichina!) Каб. \(change.cabinet!)"
                        }
                        else if change.para.contains("5") {
                            self.fiveLesson.text = "\(change.prichina!) Каб. \(change.cabinet!)"
                        }
                        else if change.para.contains("6") {
                            self.sixLesson.text = "\(change.prichina!) Каб. \(change.cabinet!)"
                        }
                        else if change.para.contains("7") {
                            self.sevenLesson.text = "\(change.prichina!) Каб. \(change.cabinet!)"
                        }
                    }
                }
            }
           
        
        }
        
        session.resume()
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
