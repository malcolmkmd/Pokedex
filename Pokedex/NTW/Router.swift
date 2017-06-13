//
//  Router.swift
//  Pokedex
//
//  Created by Malcolm Kumwenda on 2017/06/13.
//  Copyright © 2017 ByteOrbit. All rights reserved.
//

import Foundation

let base = "http://pokeapi.co/api/v2"

enum API {
    case pokemon(Int)
    var endPoint: String {
        switch self {
        case .pokemon(let id): return "\(base)/pokemon/\(id)/"
        }
    }
}
