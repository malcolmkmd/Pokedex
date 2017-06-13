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
    var Pokemon: Pokemon!

    override func viewDidLoad() {
        super.viewDidLoad()
        name.text = Pokemon.name
    }
}
