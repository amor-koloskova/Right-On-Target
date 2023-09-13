//
//  CommonViewController.swift
//  Right On Target
//
//  Created by Amor on 13.09.2023.
//

import UIKit

class CommonViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func hideCurrentScene() {
        self.dismiss(animated: true, completion: nil)
    }
    
        func updateLabelWithNewText( labelText: inout String, newText: String) {
        labelText = newText
     }
    
        func showAlertWith(score: Int) {
            let alert = UIAlertController(
            title: "Игра окончена",
            message: "Вы заработали \(score) очков",
            preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Начать заново", style:
            .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            }    
}
