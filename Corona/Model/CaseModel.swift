//
//  CaseModel.swift
//  Corona
//
//  Created by MM on 5/8/20.
//  Copyright © 2020 MM. All rights reserved.
//

import Foundation

struct CaseModel: Codable {
    let Country: String
    let Lat: String
    let Lon: String
    let Confirmed: Int
    let Deaths: Int
    let Recovered: Int
    let Active: Int
}
