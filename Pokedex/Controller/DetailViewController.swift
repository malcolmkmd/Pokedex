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
    
    var myPokemon: Pokemon!

    override func viewDidLoad() {
        super.viewDidLoad()
        name.text = myPokemon.name
        
        myPokemon.downloadDetails {
            self.updateUI()
        }
    }
    
    func updateUI(){
        
    }
    
    @IBAction func backPressed(_ sender: UIButton){
        dismiss(animated: true, completion: nil)
    }
}
