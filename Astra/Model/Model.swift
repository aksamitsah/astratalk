//
//  Model.swift
//  Astra
//
//  Created by Amit Shah on 22/09/23.
//

import Foundation

struct ResposneModel: Codable{
    let Search: [ResponseData]?
    let totalResults: String?
    let Response:  String?
}

struct ResponseData: Codable{
    let Title: String?
    let Year: String?
    let imdbID: String?
    let `Type`: String?
    let Poster: String?
}
