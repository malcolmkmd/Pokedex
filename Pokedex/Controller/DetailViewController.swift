//
//  DetailViewController.swift
//  Pokedex
//
//  Created by Malcolm Kumwenda on 2017/06/13.
//  Copyright © 2017 ByteOrbit. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var pokeIDLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var subImageOne: UIImageView!
    @IBOutlet weak var subImageTwo: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var myPokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        activityIndicator.startAnimating()
        mainImage.image = UIImage(named: "\(myPokemon.pokedexId!)")
        name.text = myPokemon.name.capitalized
        myPokemon.downloadDetails {
            self.updateUI()
        }
    }
    
    func updateUI(){
        pokeIDLabel.text = "\(myPokemon.pokedexId!)"
        weightLabel.text = myPokemon.weight
        heightLabel.text = myPokemon.height
        typeLabel.text = myPokemon.type
        attackLabel.text = myPokemon.attack
        defenseLabel.text = myPokemon.defense
        activityIndicator.stopAnimating()
    }
    
    @IBAction func backPressed(_ sender: UIButton){
        dismiss(animated: true, completion: nil)
    }
}
