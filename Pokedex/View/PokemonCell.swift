//
//  PokemonCell.swift
//  Pokedex
//
//  Created by Malcolm Kumwenda on 2017/06/13.
//  Copyright © 2017 ByteOrbit. All rights reserved.
//

import UIKit

class PokemonCell: UICollectionViewCell {
    @IBOutlet weak var pokeImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var pokemon: Pokemon? {
        didSet {
            setupUI()
        }
    }
    
    func setupUI(){
        layer.cornerRadius = 3
        nameLabel.text = pokemon?.name.capitalized
        pokeImageView.image = UIImage(named: "\(pokemon?.pokedexId ?? 1)")
    }
}
