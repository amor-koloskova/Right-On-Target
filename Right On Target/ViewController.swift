import UIKit

class ViewController: UIViewController {
    
    override func loadView() {
        super.loadView()
        print("loadView")
        
        let newLabel = UILabel(frame: CGRect(x: 350, y: 40, width: 200, height: 20))
        newLabel.text = "Угадай где число :)"
        newLabel.font = UIFont(name: "Copperplate", size: 20)
        newLabel.textColor = UIColor(red: 0.632, green: 0.566, blue: 0.586, alpha: 1)
        self.view.addSubview(newLabel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        
        self.number = Int.random(in: 0...50)
        self.label.text = String(number)
        
        slider.minimumValue = 0.0
        slider.maximumValue = 50.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear")
    }
    
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet var slider: UISlider! {
        didSet {
            slider.value = 25.0
        }
    }
    @IBOutlet var label: UILabel!
 
    
    var number: Int = 0
    var round: Int = 1
    var points: Int = 0

    lazy var secondViewController: SecondViewController = getSecondViewController()
    
    private func getSecondViewController() -> SecondViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "SecondViewController")
        return viewController as! SecondViewController
    }
    
    
    @IBAction func showNextScreen() {
        self.present(secondViewController, animated: true)
    }
    
    @IBAction func changeColor(_ sender: Any) {
        let sliderValue = CGFloat(self.slider.value)
        view.backgroundColor = UIColor(red: sliderValue/32, green: sliderValue/25, blue: sliderValue/28, alpha: 0.7)
   }
    
    @IBAction func checkNumber() {
//        if self.round == 0 {
//            self.number = Int.random(in: 0...50)
//            self.label.text = String(number)
//            self.round = 1
//        } else {
            let numSlider = Int(self.slider.value.rounded())
            if numSlider > self.number {
                self.points += 50 - numSlider + self.number
            } else if numSlider <  self.number {
                self.points += 50 - self.number + numSlider
            } else {
                self.points += 50
            }
            if self.round == 5 {
                // выводим информационное окно // с результатами игры
                let alert = UIAlertController(
                    title: "Игра окончена",
                    message: "Вы заработали \(self.points) очков", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Начать заново", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                self.round = 1
                self.points = 0
            } else {
            self.round += 1
            }
            // генерируем случайное число
            self.number = Int.random(in: 0...50)
            // передаем значение случайного числа в label
            self.label.text = String(self.number)
    }
}
