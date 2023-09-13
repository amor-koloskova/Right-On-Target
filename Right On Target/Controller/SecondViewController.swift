import UIKit

class SecondViewController: CommonViewController {
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
        updateLabelWithNewText(labelText: &(colorLabel.text)!, newText: String (game.currentRound.currentSecretValue))
        changeButtonsColor(text: colorLabel.text!)
    }
    
    override func hideCurrentScene() {
        super.hideCurrentScene()
    }
    
    override func showAlertWith(score: Int) {
        super.showAlertWith(score: score)
    }
    
    override func updateLabelWithNewText(labelText: inout String, newText: String) {
        super.updateLabelWithNewText(labelText: &labelText, newText: newText)
    }
    
    private func changeButtonsColor(text: String) {
        let generator = ColorGenerator()
        var buttons: Set <UIButton> = [firstButton, secondButton, thirdButton, fourthButton]
        let randomButton = buttons.randomElement()!
        randomButton.backgroundColor = UIColor(hex: "\(text)")
        buttons.remove(randomButton)
        for button in buttons {
            button.backgroundColor = UIColor(hex: generator.getRandomValue())
        }
    }
    
    
    @IBAction func checkColor(_ sender: UIButton) {
        let buttonColor: UIColor = sender.backgroundColor!
        game.currentRound.calculateScore(with: buttonColor)
        if game.isGameEnded {
            showAlertWith(score: game.score)
            game.restartGame()
        } else {
            game.startNewRound()
        }
        updateLabelWithNewText(labelText: &(colorLabel.text)!, newText: String (game.currentRound.currentSecretValue))
        changeButtonsColor(text: colorLabel.text!)
    }
}
    



