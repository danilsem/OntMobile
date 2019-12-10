//
//  ContactUsViewController.swift
//  OntMobile
//
//  Created by Admin on 04/12/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class ContactUsViewController: UIViewController {

    @IBAction func countactButtonTouch(_ sender: Any) {
        let alert = UIAlertController(title: "Обратная связь", message: "Сообщение успешно отправленно.\nЖдите ответа от администрации.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
