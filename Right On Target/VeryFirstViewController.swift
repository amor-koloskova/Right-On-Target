//
//  VeryFirstViewController.swift
//  Right On Target
//
//  Created by Amor on 09.09.2023.
//

import UIKit

class VeryFirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    lazy var viewController: ViewController  = getViewController()
//    lazy var secondViewController: SecondViewController = getViewController()
    
    private func getViewController <T>() -> T {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "\(T.self)")
        return viewController as! T
    }
    
//    @IBAction func showNextScreen() {
//        self.present(viewController, animated: true, completion: nil)
//    }
    
    @IBAction func openColorGame() {
            self.present(viewController, animated: true, completion: nil)
    }
    
    
}
