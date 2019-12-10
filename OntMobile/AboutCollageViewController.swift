//
//  AboutCollageViewController.swift
//  OntMobile
//
//  Created by Admin on 29/11/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import MapKit

class OntAnnotation : NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    
    init(coords: CLLocationCoordinate2D, title: String) {
        self.coordinate = coords
        self.title = title
    }
}

class AboutCollageViewController: UIViewController {

    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let center = CLLocationCoordinate2D(latitude: 51.2460427, longitude: 58.4600235)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 1000, longitudinalMeters: 1000)
        let annotation = OntAnnotation(coords: center, title: "Орский нефтяной техникум")
            
        
        self.map.setRegion(region, animated: true)
        self.map.addAnnotation(annotation)
    
        
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
