//
//  ViewController.swift
//  Pokedex
//
//  Created by Malcolm Kumwenda on 2017/06/13.
//  Copyright © 2017 ByteOrbit. All rights reserved.
//

import UIKit
import AVFoundation

class MainViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokemon = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    var isSearching = false
    var musicPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        parsePokemon(from: "pokemon")
        initAudioPlayer()
    }
    
    func initAudioPlayer(){
        guard let path = Bundle.main.path(forResource: "music", ofType: "mp3") else { return }
        
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
        } catch let error {
            fatalError(error.localizedDescription)
        }
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
    
    
    @IBAction func musicPressed(_ sender: UIButton){
        if musicPlayer.isPlaying {
            musicPlayer.pause()
            sender.alpha = 0.2
        }else {
            musicPlayer.play()
            sender.alpha = 1
        }
    }
}


//MARK: CollectionViewDelegate, CollectionViewDataSource, CollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokeCell", for: indexPath) as? PokemonCell {
            if isSearching {
                cell.pokemon = filteredPokemon[indexPath.row]
            }else {
                cell.pokemon = pokemon[indexPath.row]
            }
            
            return cell
        }else {
            fatalError("Unable to deque PokemonCell")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var selected: Pokemon!
        if isSearching {
            selected = filteredPokemon[indexPath.row]
        }else {
            selected = pokemon[indexPath.row]
        }
        
        performSegue(withIdentifier: "pokeDetailVC", sender: selected)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pokeDetailVC" {
            if let destination = segue.destination as? DetailViewController {
                destination.Pokemon = sender as? Pokemon
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearching {
            return filteredPokemon.count
        }else {
           return pokemon.count
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 110)
    }
}

//MARK: SearchbarDelegate
extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
            collectionView.reloadData()
            view.endEditing(true)
            view.resignFirstResponder()
        }else {
            isSearching = true
            
            guard let query = searchBar.text?.lowercased() else { return }
            filteredPokemon = pokemon.filter { $0.name.range(of: query) != nil }
            collectionView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        view.resignFirstResponder()
    }
    
}
