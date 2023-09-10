import UIKit

class SecondViewController: UIViewController {
    var game: Game!
    
    @IBOutlet weak var colorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let generator = NumberGenerator(startValue: 1, endValue: 40)
        game = Game(valueGenerator: generator!, rounds: 5)
        updateLabelWithNewColor(newText: String(game.currentRound.currentSecretValue))
    }
    
    @IBAction func hideCurrentScene() {
            self.dismiss(animated: true, completion: nil)
    }
    
    private func updateLabelWithNewColor(newText: String) {
       colorLabel.text = newText }
    
}


