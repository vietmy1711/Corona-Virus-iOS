//
//  CaseManager.swift
//  Corona
//
//  Created by MM on 5/8/20.
//  Copyright © 2020 MM. All rights reserved.
//

import Foundation


protocol CaseManagerDelegate {
    func didUpdateCase(_ caseManager: CaseManager,_ caseModel: CaseModel)
    func didFailWithError(error: Error)
}

struct CaseManager {
    let caseURL = "https://api.covid19api.com/live/country/"
    
    var delegate: CaseManagerDelegate?
    
    
    func fetchCase(countryName: String) {
        let name = countryName.replacingOccurrences(of: " ", with: "-")
        let urlString = "\(caseURL)\(name)"
        performRequest(with: urlString)
    }
    
    func performRequest (with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                guard error == nil else { return }
                guard let safeData = data else { return }
                guard let caseGet = self.parseJSON(caseData: safeData) else { return }
                self.delegate?.didUpdateCase(self, caseGet)
                
                
            }
            task.resume()
        }
    }
    
    func parseJSON(caseData: Data) -> CaseModel? {
        let decoder = JSONDecoder()
        do {
            
            let decodedData = try decoder.decode([CaseModel].self, from: caseData)
            let countryName = decodedData.last?.Country ?? "No country found"
            let lat = decodedData.last?.Lat ?? "No location found"
            let lon = decodedData.last?.Lon ?? "No location found"
            let confirmed = decodedData.last?.Confirmed ?? 0
            let deaths = decodedData.last?.Deaths ?? 0
            let recovered = decodedData.last?.Recovered ?? 0
            let active = decodedData.last?.Active ?? 0
            
            let caseModel = CaseModel(Country: countryName, Lat: lat, Lon: lon, Confirmed: confirmed, Deaths: deaths, Recovered: recovered, Active: active)
            return caseModel
        } catch {
            
            self.delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
    
    
    
}

