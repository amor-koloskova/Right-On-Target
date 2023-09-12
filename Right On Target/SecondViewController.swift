import UIKit

class SecondViewController: UIViewController {
    var game: ColorGame!
    
    @IBOutlet weak var colorLabel: UILabel!
    
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    @IBOutlet weak var fourthButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let generator = ColorGenerator()
        game = ColorGame(valueGenerator: generator, rounds: 5)
        updateLabelWithNewColor(newText: String (game.currentRound.currentSecretValue))
        changeButtonsColor(text: colorLabel.text!)
    }
    
    @IBAction func hideCurrentScene() {
            self.dismiss(animated: true, completion: nil)
    }
    
    private func updateLabelWithNewColor(newText: String) {
        colorLabel.text = newText
    }
    
    private func changeButtonsColor(text: String) {
        let generator = ColorGenerator()
        var buttons: Set <UIButton> = [firstButton, secondButton, thirdButton, fourthButton]
        var randomButton = buttons.randomElement()!
        randomButton.backgroundColor = UIColor(hex: "\(text)")
        buttons.remove(randomButton)
        for button in buttons {
            button.backgroundColor = UIColor(hex: generator.getRandomValue())
        }
    }
}


