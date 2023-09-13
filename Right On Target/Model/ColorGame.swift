//
//  Trying.swift
//  Right On Target
//
//  Created by Amor on 12.09.2023.
//

import UIKit

final class ColorGame: GameProtocol {
    
    typealias Round = ColorGameRound
    typealias Generator = ColorGenerator
    
    var currentRound: Round!
    var score: Int {
        var totalScore: Int = 0
        
        for round in self.rounds {
            totalScore += round.score
        }
        return totalScore
    }
    
    private var rounds: [ColorGameRound] = []
    var secretValueGenerator: ColorGenerator
    private var roundsCount: Int!
    
    var isGameEnded: Bool {
        if roundsCount == rounds.count {
            return true
        } else {
            return false
        }
    }
    init(valueGenerator: ColorGenerator, rounds: Int) {
        secretValueGenerator = valueGenerator
        roundsCount = rounds
        startNewRound()
    }
    
    func restartGame() {
        rounds = []
        startNewRound()
    }
    
    func startNewRound() {
        typealias ValueType = String
        let newSecretValue: ValueType = getNewSecretValue()
        currentRound = ColorGameRound(secretValue: (newSecretValue))
        rounds.append(currentRound)
    }
    
    private func getNewSecretValue() -> String {
        let newSecretValue: String = secretValueGenerator.getRandomValue()
        return newSecretValue
    }
    
}

final class ColorGameRound: GameRoundProtocol {
    typealias ValueType = String
    typealias ColorType = UIColor
    var score: Int = 0
    var currentSecretValue: ValueType
    init(secretValue: ValueType) {
        currentSecretValue = secretValue
    }
    
    func calculateScore(with value: ColorType) {
        let newValue = UIColor(hex: currentSecretValue)
        if value == newValue {
            score = 5
        } else {
            score = 0
        }
    }
}

final class ColorGenerator: GeneratorProtocol {
    typealias ValueType = String
    
    func getRandomValue() -> ValueType {
            let a = ["1","2","3","4","5","6","7","8","9","a","b","c","d","e","f"]
            return "#".appending(a[Int.random(in:0..<15)]).appending(a[Int.random(in:0..<15)]).appending(a[Int.random(in:0..<15)].appending(a[Int.random(in:0..<15)]).appending(a[Int.random(in:0..<15)]).appending(a[Int.random(in:0..<15)]))
    }
}
