//
//  TimetableShowViewController.swift
//  OntMobile
//
//  Created by Admin on 27/12/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

protocol TimetableDataProtocol {
    var day: String! {get set}
    var group: String! {get set}
}

struct GroupTimetable {
    var cabinet: String
    var group: String
    var type: String
    var para: String
    var discipline: String
}

class TimetableShowViewController: UIViewController {
    
    var dataProtocol: TimetableDataProtocol? = nil
    var gtA: Array<GroupTimetable> = [] // 

    @IBOutlet weak var dayText: UILabel!
    
    @IBOutlet weak var firstPara: UILabel!
    @IBOutlet weak var secondPara: UILabel!
    @IBOutlet weak var thirdPara: UILabel!
    @IBOutlet weak var fourPara: UILabel!
    @IBOutlet weak var fivePara: UILabel!
    @IBOutlet weak var sixPara: UILabel!
    @IBOutlet weak var sevenPara: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dayText.text = dataProtocol?.day
        
        self.firstPara.text = "-----"
        self.secondPara.text = "-----"
        
        let group: String = dataProtocol!.group
        let day: String = dataProtocol!.day
        
        var url = "http://api.ontvkr.ru/raspisanie/search.php?s=\(group)&&p=\(day)"
        
        url = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let session = URLSession.shared.dataTask(with: URL(string: url)!) {
            data, _, _ in
            
            //guard let self = self else {return}
            guard let data = data else {return}
            
            var json: Dictionary<String, Any>!
            
            do {
                json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! Dictionary<String, Any>
            }
            catch {
                
            }
            let gtArray = json["records"] as? Array<Dictionary<String, Any>>
            
            if let gtArray = gtArray {
                DispatchQueue.main.async {
                for gt in gtArray {
                    let gtO: GroupTimetable = GroupTimetable(cabinet: gt["id_kab"] as! String, group: gt["gruppa"] as! String, type: gt["tip"] as! String, para: gt["para"] as! String, discipline: gt["disciplina"] as! String)
                    
                    self.gtA.append(gtO)
                }
                
                for gt in self.gtA {
                    if gt.para == "1" {
                        switch gt.type {
                        case "Общий":
                            self.firstPara.text = "\(gt.discipline) Каб. \(gt.cabinet)"
                        case "Числитель":
                            self.firstPara.text! += "\(gt.discipline) Каб. \(gt.cabinet)\n"
                        case "Знаменатель":
                            self.firstPara.text! += "\(gt.discipline) Каб. \(gt.cabinet)\n"
                        default:
                            self.firstPara.text = "-----"
                        }
                    }
                    if gt.para == "2" {
                        switch gt.type {
                        case "Общий":
                            self.secondPara.text = "\(gt.discipline) Каб. \(gt.cabinet)"
                        case "Числитель":
                            self.secondPara.text! += "\(gt.discipline) Каб. \(gt.cabinet)\n"
                        case "Знаменатель":
                            self.secondPara.text! += "\(gt.discipline) Каб. \(gt.cabinet)\n"
                        default:
                            self.secondPara.text = "-----"
                        }
                    }
                    if gt.para == "3" {
                        switch gt.type {
                        case "Общий":
                            self.thirdPara.text = "\(gt.discipline) Каб. \(gt.cabinet)"
                        case "Числитель":
                            self.thirdPara.text! += "\(gt.discipline) Каб. \(gt.cabinet)\n----------\n"
                        case "Знаменатель":
                            self.thirdPara.text! += "\n\(gt.discipline) Каб. \(gt.cabinet)\n----------\n"
                        default:
                            self.thirdPara.text = "-----"
                        }
                    }
                    if gt.para == "4" {
                        switch gt.type {
                        case "Общий":
                            self.fourPara.text = "\(gt.discipline) Каб. \(gt.cabinet)"
                        case "Числитель":
                            self.fourPara.text! += "\(gt.discipline) Каб. \(gt.cabinet)\n-----------\n"
                        case "Знаменатель":
                            self.fourPara.text! += "\(gt.discipline) Каб. \(gt.cabinet)\n"
                        default:
                            self.fourPara.text = "-----"
                        }
                    }
                    if gt.para == "5" {
                        switch gt.type {
                        case "Общий":
                            self.fivePara.text = "\(gt.discipline) Каб. \(gt.cabinet)"
                        case "Числитель":
                            self.fivePara.text! += "\(gt.discipline) Каб. \(gt.cabinet)\n"
                        case "Знаменатель":
                            self.fivePara.text! += "\(gt.discipline) Каб. \(gt.cabinet)\n"
                        default:
                            self.fivePara.text = "-----"
                        }
                    }
                    if gt.para == "6" {
                        switch gt.type {
                        case "Общий":
                            self.sixPara.text = "\(gt.discipline) Каб. \(gt.cabinet)"
                        case "Числитель":
                            self.sixPara.text! += "\(gt.discipline) Каб. \(gt.cabinet)\n"
                        case "Знаменатель":
                            self.sixPara.text! += "\(gt.discipline) Каб. \(gt.cabinet)\n"
                        default:
                            self.sixPara.text = "-----"
                        }
                    }
                    if gt.para == "7" {
                        switch gt.type {
                        case "Общий":
                            self.sevenPara.text = "\(gt.discipline) Каб. \(gt.cabinet)"
                        case "Числитель":
                            self.sevenPara.text! += "\(gt.discipline) Каб. \(gt.cabinet)\n"
                        case "Знаменатель":
                            self.sevenPara.text! += "\(gt.discipline) Каб. \(gt.cabinet)\n"
                        default:
                            self.sevenPara.text = "-----"
                        }
                    }
                }
                }
            }
            
            
            
        }
        session.resume()
    }

}
