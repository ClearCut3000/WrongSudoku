//
//  ContentView.swift
//  WrongSudoku
//
//  Created by Николай Никитин on 08.12.2022.
//

import SwiftUI

struct ContentView: View {

  @StateObject private var board = Board(.medium)
  @State private var isGameOver = false

  var body: some View {

    NavigationStack {
      VStack {
        Spacer()

        Grid(horizontalSpacing: 2, verticalSpacing: 2) {
          ForEach(0..<board.exampleCells.count, id: \.self) { row in
            GridRow {
              let exampleRow = board.exampleCells[row]
              let userRow = board.userCells[row]

              ForEach(0..<userRow.count, id: \.self) { column in
                let selected = row == board.selectedRow && column == board.selectedColumn
                let userValue = userRow[column] == 0 ? "" : String(userRow[column])

                CellView(number: userRow[column], isSelected: selected) {
                  board.selectedRow = row
                  board.selectedColumn = column
                }
                .accessibilityValue(userValue)
                .accessibilityLabel("Row \(row) column \(column)")
                .accessibilityAddTraits(selected ? .isSelected : .isButton)
              }
              let exampleSum = sum(forRow: exampleRow)
              let userSum = sum(forRow: userRow)
              SumView(number: exampleSum)
                .foregroundColor(exampleSum == userSum ? .primary : .red)
                .accessibilityLabel("Row \(row + 1) sum: \(exampleSum)")
                .accessibilityHint(exampleSum == userSum ? "Correct" : "Incorrect")
            }
          }
          GridRow {
            ForEach(0..<board.exampleCells[0].count, id: \.self) { column in
              let exampleSum = sum(forColumn: column, in: board.exampleCells)
              let userSum = sum(forColumn: column, in: board.userCells)
              SumView(number: exampleSum)
                .foregroundColor(exampleSum == userSum ? .primary : .red)
                .accessibilityLabel("Column \(column + 1) sum: \(exampleSum)")
                .accessibilityHint(exampleSum == userSum ? "Correct" : "Incorrect")
            }
          }
        }
        .padding(.horizontal)

        Spacer()

        HStack {
          ForEach(1..<10) { i in
            Button(String(i)) {
              board.enter(i)
            }
            .accessibilityLabel("Enter\(i)")
            .accessibilityHint(board.hint(for: i))
            .frame(maxWidth: .infinity)
            .font(.largeTitle)
          }
        }
        .padding()

        Button("Submit") {
          isGameOver = true
        }
        .buttonStyle(.borderedProminent)
        .disabled(board.isSolved == false)

        Spacer()
      }
      .navigationTitle("Wrong Sudoku!")
      .toolbar {
        Button {
          isGameOver = true
        } label: {
          Label("Start a New Game", systemImage: "plus")
        }
      }
      .alert("Start a new Game", isPresented: $isGameOver) {
        ForEach(Difficulty.allCases, id: \.self) { difficulty in
          Button(String(describing: difficulty).capitalized) {
            startGame(difficulty)
          }
        }
        Button("Cancel", role: .cancel) { }
      } message: {
        if board.isSolved {
          Text("You solved the board correctly - good job!")
        }
      }
      .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
    }
  }

  func sum(forRow row: [Int]) -> Int {
    row.reduce(0, +)
  }

  func sum(forColumn column: Int, in cells: [[Int]]) -> Int {
    cells.reduce(0) { $0 + $1[column] }
  }

  func startGame(_ diffculty: Difficulty) {
    isGameOver = false
    board.create(diffculty)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
