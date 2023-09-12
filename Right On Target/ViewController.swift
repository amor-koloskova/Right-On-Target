import UIKit

class ViewController: UIViewController {
    
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
        newLabel.textColor = UIColor(red: 0.632, green: 0.566, blue: 0.586, alpha: 1)
        self.view.addSubview(newLabel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let generator = NumberGenerator(startValue: 1, endValue: 50)
        game = NumberGame(valueGenerator: generator!, rounds: 5)
        
        updateLabelWithSecretNumber(newText: String(game.currentRound.currentSecretValue))
        
        slider.minimumValue = 0.0
        slider.maximumValue = 50.0
    }
    
    @IBAction func hideCurrentScene() {
        self.dismiss(animated: true, completion: nil)
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
        updateLabelWithSecretNumber(newText: String(game.currentRound.currentSecretValue))
    }
    // MARK: - Обновление View
    // Обновление текста загаданного числа
     private func updateLabelWithSecretNumber(newText: String) {
        label.text = newText
         
     }
        // Отображение всплывающего окна со счетом
        private func showAlertWith(score: Int) {
        let alert = UIAlertController(
        title: "Игра окончена",
        message: "Вы заработали \(score) очков",
        preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Начать заново", style:
        .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        }
}
