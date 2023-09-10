//
//  Game.swift
//  Right On Target
//
//  Created by Amor on 06.09.2023.
//

import Foundation

protocol GameProtocol {
    // Количество заработанных очков
    var score: Int { get }
    // текущий раунд
    var currentRound: GameRoundProtocol! { get }
    // Проверяет, окончена ли игра
    var isGameEnded: Bool { get }
    // Генератор случайного значения
    var secretValueGenerator: GeneratorProtocol { get }
    // Начинает новую игру и сразу стартует первый раунд
    func restartGame()
    // Начинает новый раунд
    func startNewRound()
}

protocol GameRoundProtocol {
    // количество заработанных за раунд очков
    var score: Int { get }
    // загаданное значение
    var currentSecretValue: Int { get }
    // подсчет заработанных за раунд очков
    func calculateScore(with value: Int)
}

protocol GeneratorProtocol {
    func getRandomValue() -> Int?
}

class Game: GameProtocol {
    var score: Int {
        var totalScore: Int = 0
        for round in self.rounds {
            totalScore += round.score
        }
        return totalScore
    }
    var currentRound: GameRoundProtocol!
    private var rounds: [GameRoundProtocol] = []
    var secretValueGenerator: GeneratorProtocol
    private var roundsCount: Int!
    var isGameEnded: Bool {
        if roundsCount == rounds.count {
            return true
        } else {
            return false
        }
    }

    init(valueGenerator: GeneratorProtocol, rounds: Int) {
        secretValueGenerator = valueGenerator
        roundsCount = rounds
        startNewRound()
    }
    
    func restartGame() {
        rounds = []
        startNewRound()
    }

    func startNewRound() {
        let newSecretValue = self.getNewSecretValue()
        currentRound = GameRound(secretValue: Int(newSecretValue))
        rounds.append( currentRound )
    }

    // Загадать и вернуть новое случайное значение
    private func getNewSecretValue() -> Int {
        let newSecretValue: Int = secretValueGenerator.getRandomValue()!
        return newSecretValue
    }
}

class GameRound: GameRoundProtocol {
    var score: Int = 0
    var currentSecretValue: Int = 0
    init(secretValue: Int) {
        currentSecretValue = secretValue
    }
    // подсчитывает количество очков
    func calculateScore(with value: Int) {
        if value > currentSecretValue {
            score = 50 - value + currentSecretValue
        } else if value < currentSecretValue {
            score = 50 - currentSecretValue + value
        } else {
            score = 50
        }
    }
}

class NumberGenerator: GeneratorProtocol {
    private let startRangeValue: Int
    private let endRangeValue: Int
    init?(startValue: Int, endValue: Int) {
        guard startValue <= endValue else {
            return nil
        }
        startRangeValue = startValue
        endRangeValue = endValue
    }
    func getRandomValue<T>() -> T? {
        if let _ = T.self as? any Numeric.Type {
            return (startRangeValue...endRangeValue).randomElement()! as? T
        } else if let _ = T.self as? String.Type {
            let a = ["1","2","3","4","5","6","7","8","9","a","b","c","d","e","f"]
            return "#".appending(a[Int.random(in:0..<15)]).appending(a[Int.random(in:0..<15)]).appending(a[Int.random(in:0..<15)].appending(a[Int.random(in:0..<15)]).appending(a[Int.random(in:0..<15)]).appending(a[Int.random(in:0..<15)])) as! T?
        } else {
            return nil
        }
    }
}
