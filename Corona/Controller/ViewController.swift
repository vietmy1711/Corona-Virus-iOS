//
//  ViewController.swift
//  Corona
//
//  Created by MM on 5/8/20.
//  Copyright © 2020 MM. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var lblCountryName: UILabel!
    @IBOutlet weak var lblConfirmed: UILabel!
    @IBOutlet weak var lblDeaths: UILabel!
    @IBOutlet weak var lblRecovered: UILabel!
    @IBOutlet weak var lblActive: UILabel!
        
    var location = CLLocationManager()
    var caseManager = CaseManager()
    var countryLat: Double?
    var countryLon: Double?

    override func viewDidLoad() {
        super.viewDidLoad()
        caseManager.delegate = self
        searchBar.delegate = self
    }
    
    @IBAction func mapKitSelected(_ sender: UIButton) {
        if checkCountry() == false {
            return
        }
        let mapKitVC = MapKitViewController()
        mapKitVC.lat = countryLat
        mapKitVC.lon = countryLon
        navigationController?.pushViewController(mapKitVC, animated: true)
    }
    
    @IBAction func googleMapSelected(_ sender: UIButton) {
        if checkCountry() == false {
            return
        }
        let googleMapVC = GoogleMapViewController()
        googleMapVC.lat = countryLat
        googleMapVC.lon = countryLon
        navigationController?.pushViewController(googleMapVC, animated: true)
    }
    
    func checkCountry() -> Bool {
        if lblCountryName.text == "Country Name:" || lblCountryName.text == "Country Name: No country found" {
            return false
        }
        return true
    }
}

//MARK: - UISearchBarDelegate

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchCountry = searchBar.text {
            caseManager.fetchCase(countryName: searchCountry)
        }
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if let searchCountry = searchBar.text {
            caseManager.fetchCase(countryName: searchCountry)
        }
    }
}

//MARK: - CaseManagerDelegate

extension ViewController: CaseManagerDelegate {
    func didUpdateCase(_ caseManager: CaseManager, _ caseModel: CaseModel) {
        self.countryLat = Double(caseModel.Lat)
        self.countryLon = Double(caseModel.Lon)
        DispatchQueue.main.async {
            self.lblCountryName.text = String("Country Name: \(caseModel.Country)")
            self.lblConfirmed.text = String("Confirmed: \(caseModel.Confirmed)")
            self.lblRecovered.text = String("Recovered: \(caseModel.Recovered)")
            self.lblDeaths.text = String("Deaths: \(caseModel.Deaths)")
            self.lblActive.text = String("Active: \(caseModel.Active)")
                        
            //self.mapView.setCenter(self.locationReceived, animated: true)
        }
        
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}
