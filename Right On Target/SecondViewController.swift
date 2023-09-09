import UIKit

class SecondViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func hideCurrentScene() {
            self.dismiss(animated: true, completion: nil)
    }
    
}


