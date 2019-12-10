//
//  FirstViewController.swift
//  OntMobile
//
//  Created by Admin on 20/11/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import SwiftSoup

class FirstViewController: UIViewController {

    var news = [News]()
    
    @IBOutlet weak var loadIndicator: UIActivityIndicatorView!
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var ollectionView: UICollectionView!
    
    @IBAction func buttonTouch(_ sender: Any) {
        for n in news {
            print(n.imageUrl ?? "Null")
        }
    }
    
    var html = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let session = URLSession.shared.dataTask(with: URL(string: "http://nt-orsk.ru/index.php/novosti")!) {
            (data, response, error) in
            
            let dataHtml = String(data: data!, encoding: .utf8)
            
            DispatchQueue.main.async {
                self.html = dataHtml!
                
                do {
                    let parsedHtml = try SwiftSoup.parse(dataHtml!)
                    
                    let arrayOfPosts = try parsedHtml.getElementsByClass("blog")[0].getElementsByAttributeValue("itemprop", "blogpost").array()

                    
                    for post in arrayOfPosts {
                        let novost = News()
                        
                        novost.title = try post.getElementsByAttributeValue("itemprop", "url")[0].text()
                        
                        novost.url = try "http://nt-orsk.ru/" + ((post.getElementsByAttributeValue("itemprop", "url")[0].getAttributes()?.get(key: "href"))!)
                        
                        novost.imageUrl = try "http://nt-orsk.ru/" + (post.getElementsByTag("img")[0].getAttributes()?.get(key: "src"))!
                        
                        self.news.append(novost)
                        
                    }
                    
                    self.ollectionView.reloadData()
                    self.loadIndicator.isHidden = true
                }
                catch {
                    print("Error")
                }
            }
        }
        
        session.resume()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NewsDetailIdendifier" {
            guard let vc = segue.destination as? NewsDetailViewController else {return}
            vc.news = sender as? News
            
            
        }
    }


}

extension FirstViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.news.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCollectionViewCell", for: indexPath) as! NewsCollectionViewCell
        
        cell.name.text = news[indexPath.row].title
        do {
            cell.image.image = try UIImage(data: Data(contentsOf: URL(string: news[indexPath.row].imageUrl!)!))
        } catch {
            
        }
        
        //cell.layer.backgroundColor = CGColor(srgbRed: 0.7, green: 0.7, blue: 0.7, alpha: 0.2)
        //cell.layer.cornerRadius = 10.0
        cell.layer.masksToBounds = false
        //cell.layer.borderWidth = 1.0
        //cell.layer.borderColor = CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 0.2)
        
        cell.contentView.layer.masksToBounds = true
        cell.contentView.layer.cornerRadius = 10.0
        
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedNews = news[indexPath.row]
        
        performSegue(withIdentifier: "NewsDetailIdendifier", sender: selectedNews)
        
    }
    
}

