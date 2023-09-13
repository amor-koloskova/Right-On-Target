import UIKit

class ViewController: CommonViewController {
    
    // Сущность "игра"
    var game: NumberGame!
    
    // Элементы на сцене
    @IBOutlet weak var colorView: UIView!
    @IBOutlet var slider: UISlider! {
        didSet {
            slider.value = 25.0
        }
    }
    @IBOutlet var label: UILabel!
    
    // MARK: - Жизненный цикл
    
    override func loadView() {
        super.loadView()
        
        let newLabel = UILabel(frame: CGRect(x: 350, y: 40, width: 200, height: 20))
        newLabel.text = "Угадай где число :)"
        newLabel.font = UIFont(name: "Copperplate", size: 20)
        newLabel.textColor = UIColor(red: 0.632, green: 0.566, blue: 0.586, alpha: 0.7)
        self.view.addSubview(newLabel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let generator = NumberGenerator(startValue: 1, endValue: 50)
        game = NumberGame(valueGenerator: generator!, rounds: 5)
        
        updateLabelWithNewText(labelText: &(label.text)!, newText: String(game.currentRound.currentSecretValue))
        
        slider.minimumValue = 0.0
        slider.maximumValue = 50.0
    }
    
    override func hideCurrentScene() {
        super.hideCurrentScene()
    }
    
    @IBAction func changeColor(_ sender: Any) {
        let sliderValue = CGFloat(self.slider.value)
        view.backgroundColor = UIColor(red: sliderValue/32, green: sliderValue/25, blue: sliderValue/28, alpha: 1)
    }
    
    @IBAction func checkNumber() {
        let sliderValue = Int(self.slider.value)
        game.currentRound.calculateScore(with: Int(sliderValue))
        if game.isGameEnded {
            showAlertWith(score: game.score)
            game.restartGame()
        } else {
            game.startNewRound()
        }
        updateLabelWithNewText(labelText: &(label.text)!, newText: String(game.currentRound.currentSecretValue))
    }
    
    override func showAlertWith(score: Int) {
        super.showAlertWith(score: score)
    }
    
    override func updateLabelWithNewText(labelText: inout String, newText: String) {
        super.updateLabelWithNewText(labelText: &labelText, newText: newText)
    }
}
