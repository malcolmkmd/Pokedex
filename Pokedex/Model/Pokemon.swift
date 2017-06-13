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

class Pokemon {
    var name: String!
    var pokedexId: Int!
    var description: String?
    var type: String?
    var defense: String?
    var height: String?
    var weight: String?
    var attack: String?
    var nextEvolutionText: String?
    
    init(name: String, pokedexID: Int){
        self.name = name
        self.pokedexId = pokedexID
    }
    
    func downloadDetails(completed: @escaping ()->()){
        Alamofire.request(API.pokemon(pokedexId).endPoint).responseJSON(completionHandler: { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let height = json["height"].int
                let weight = json["weight"].int
                let type = json["types"][0]["type"]["name"].string
                let defense = json["defense"].int
                self.height = "\(height!)"
                self.weight = "\(weight!)"
                self.type = type
                self.defense = "\(defense ?? 0)"
            case .failure(let error):
                print(error)
            }
            completed()
        })
    }
}

