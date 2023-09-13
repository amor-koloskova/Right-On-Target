//
//  Game.swift
//  Right On Target
//
//  Created by Amor on 06.09.2023.
//

import Foundation

final class NumberGame: GameProtocol {
    typealias Round = NumberGameRound
    typealias Generator = NumberGenerator
    
    var currentRound: Round!
    var score: Int {
        var totalScore: Int = 0
        
        for round in self.rounds {
            totalScore += round.score
        }
        return totalScore
    }
    
    private var rounds: [NumberGameRound] = []
    var secretValueGenerator: NumberGenerator
    private var roundsCount: Int!
    
    var isGameEnded: Bool {
        if roundsCount == rounds.count {
            return true
        } else {
            return false
        }
    }

    init(valueGenerator: NumberGenerator, rounds: Int) {
        secretValueGenerator = valueGenerator
        roundsCount = rounds
        startNewRound()
    }
    
    func restartGame() {
        rounds = []
        startNewRound()
    }

    func startNewRound() {
        typealias ValueType = Int
        let newSecretValue: ValueType = getNewSecretValue()
        currentRound = NumberGameRound(secretValue: (newSecretValue))
        rounds.append( currentRound )
    }

    // Загадать и вернуть новое случайное значение
    private func getNewSecretValue() -> Int {
        let newSecretValue: Int = secretValueGenerator.getRandomValue()
        return newSecretValue
    }
}


final class NumberGameRound: GameRoundProtocol {
    typealias ValueType = Int
    var score: Int = 0
    var currentSecretValue: ValueType = 0
    init(secretValue: ValueType) {
        currentSecretValue = secretValue
    }
    // подсчитывает количество очков
    func calculateScore(with value: ValueType) {
            if value > currentSecretValue {
                score = 50 - value + currentSecretValue
            } else if value < currentSecretValue {
                score = 50 - currentSecretValue + value
            } else {
                score = 50
        }
    }
}

final class NumberGenerator: GeneratorProtocol {
    typealias ValueType = Int
    
    private let startRangeValue: Int
    private let endRangeValue: Int
    init?(startValue: Int, endValue: Int) {
        guard startValue <= endValue else {
            return nil
        }
        startRangeValue = startValue
        endRangeValue = endValue
    }
    func getRandomValue() -> ValueType {
            return (startRangeValue...endRangeValue).randomElement()!
    }
}
