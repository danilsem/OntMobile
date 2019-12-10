//
//  NewsDetailViewController.swift
//  OntMobile
//
//  Created by Admin on 25/11/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import SwiftSoup

class NewsDetailViewController: UIViewController {
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var text: UILabel!
    
    var news: News?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let news = news {
            do {
                image.image = try UIImage(data: Data(contentsOf: URL(string: news.imageUrl!)!))
                image.layer.cornerRadius = 10.0
                
                
                let session = URLSession.shared.dataTask(with: URL(string: news.url!)!) { data,_,_ in
                    
                    DispatchQueue.main.async {
                        do {
                            let html = try SwiftSoup.parse(String(data: data!, encoding: .utf8)!)
                            
                            self.text.text = try html.getElementsByAttributeValue("itemprop", "articleBody")[0].text()
                        }
                        catch {
                            
                        }
                    }
                    
                }
                
                session.resume()
            }
            catch {
                
            }
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
