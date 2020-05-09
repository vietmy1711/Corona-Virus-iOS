//
//  MapKitViewController.swift
//  Corona
//
//  Created by MM on 5/8/20.
//  Copyright © 2020 MM. All rights reserved.
//

import UIKit
import MapKit

class MapKitViewController: UIViewController {
    var lon: Double!
    var lat: Double!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    func setupUI() {
        let mapView = MKMapView()
        view = mapView
        //mapView.frame = view.bounds

        let coordinate = CLLocationCoordinate2DMake(lat, lon)
        DispatchQueue.main.async {
            mapView.setCenter(coordinate, animated: true)
        }
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
