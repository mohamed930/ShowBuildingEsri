//
//  responseModel.swift
//  ShowBuildingEsri
//
//  Created by Mohamed Ali on 22/11/2022.
//

import Foundation

class responseModel: Codable {
    var status: Int
    var message: String
    var building: [buildModel]
}

class buildModel: Codable {
    var id: Int
    var name: String?
    var location: buildLocationModel
}

class buildLocationModel: Codable {
    var type: String
    var lati: String
    var long: String
}
