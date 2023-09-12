//
//  Protocols.swift
//  Right On Target
//
//  Created by Amor on 12.09.2023.
//

import Foundation

protocol GameProtocol {
    associatedtype Round
    associatedtype Generator
    // Количество заработанных очков
    var score: Int { get }
    // текущий раунд
    var currentRound: Round! { get }
    // Проверяет, окончена ли игра
    var isGameEnded: Bool { get }
    // Генератор случайного значения
    var secretValueGenerator: Generator { get }
    // Начинает новую игру и сразу стартует первый раунд
    func restartGame()
    // Начинает новый раунд
    func startNewRound()
}

protocol GameRoundProtocol {
    associatedtype ValueType
    // количество заработанных за раунд очков
    var score: Int { get }
    // загаданное значение
    var currentSecretValue: ValueType { get }
    // подсчет заработанных за раунд очков
    func calculateScore(with value: ValueType)
}

protocol GeneratorProtocol {
    associatedtype ValueType
    func getRandomValue() -> ValueType
}
