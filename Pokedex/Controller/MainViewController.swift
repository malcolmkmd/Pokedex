//
//  ViewController.swift
//  Pokedex
//
//  Created by Malcolm Kumwenda on 2017/06/13.
//  Copyright © 2017 ByteOrbit. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var pokemon = [Pokemon]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        parsePokemon(from: "pokemon")
    }
    
    func parsePokemon(from csv: String){
        guard let path = Bundle.main.path(forResource: csv, ofType: "csv") else { return  }
        
        do {
            let csv = try CSVParser(contentsOfURL: path)
            let rows = csv.rows
            for row in rows {
                guard let id = Int(row["id"]!), let name = row["identifier"] else { return }
                pokemon.append(Pokemon(name: name, pokedexId: id))
            }
        }catch let error{
            fatalError(error.localizedDescription)
        }
    }
}


//MARK: CollectionViewDelegate, CollectionViewDataSource, CollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokeCell", for: indexPath) as? PokemonCell {
            cell.pokemon = pokemon[indexPath.row]
            return cell
        }else {
            fatalError("Unable to deque PokemonCell")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemon.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 110)
    }
}
