//
//  Board.swift
//  WrongSudoku
//
//  Created by Николай Никитин on 08.12.2022.
//

import Foundation

enum Difficulty: CaseIterable {
case easy, medium, tricky, taxing, nightmare
}

class Board: ObservableObject {
  var exampleCells = [[Int]]()

  @Published var userCells = [[Int]]()

  @Published var selectedRow = 0
  @Published var selectedColumn = 0

  init(_ difficulty: Difficulty) {
    create(difficulty)
  }

  func create(_ difficulty: Difficulty) {
    selectedRow = 0
    selectedColumn = 0

    let size: Int
    let maxNumber: Int

    switch difficulty {
    case .easy:
      size = 2
      maxNumber = 4
    case .medium:
      size = 3
      maxNumber = 4
    case .tricky:
      size = 4
      maxNumber = 4
    case .taxing:
      size = 5
      maxNumber = 6
    case .nightmare:
      size = 5
      maxNumber = 8
    }

    exampleCells = (0..<size).map { _ in
      (0..<size).map { _ in
        Int.random(in: 1...maxNumber)
      }
    }

    userCells = Array(repeating: Array(repeating: 0, count: size), count: size)
  }
}
