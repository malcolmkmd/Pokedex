//
//  Pokemon.swift
//  Pokedex
//
//  Created by Malcolm Kumwenda on 2017/06/13.
//  Copyright © 2017 ByteOrbit. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct Pokemon {
    var name: String!
    var pokedexId: Int!
    var description: String!
    var type: String!
    var defense: String!
    var height: String!
    var weight: String!
    var attack: String!
    var nextEvolutionText: String
    
    func downloadDetails(completed: ()->()){
        Alamofire.request(API.pokemon(pokedexId).endPoint).responseJSON(completionHandler: { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let height = json["height"].string
                let weight = json["weight"].string
                let type = json["types"]
                
            case .failure(let error):
                print(error)
            }
        })
    }
}

