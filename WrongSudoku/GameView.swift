//
//  GameView.swift
//  WrongSudoku
//
//  Created by Николай Никитин on 08.12.2022.
//

import SwiftUI

struct GameView: View {

  //MARK: - View Properties
  @StateObject private var board = Board(.medium)
  @State private var isGameOver = false
  @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
  @State private var time = 0
  @Environment(\.dismiss) private var dismiss

  //MARK: - View Body
  var body: some View {

    ZStack {
      Color("backgroundColor").ignoresSafeArea()
      VStack {
        HStack {
          Button("New Game") {
            isGameOver = true
          }
          .buttonStyle(MainGrowingButton())
        }

        Spacer()
        TimerView(font: .system(size: 30),
                  weight: .black,
                  value: $time)
        .foregroundColor(time > 9 ? Color("textColor") : Color("uncorrectSumColor"))

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
                .foregroundColor(exampleSum == userSum ? Color("correctSumColor") : Color("uncorrectSumColor"))
                .accessibilityLabel("Row \(row + 1) sum: \(exampleSum)")
                .accessibilityHint(exampleSum == userSum ? "Correct" : "Incorrect")
            }
          }
          GridRow {
            ForEach(0..<board.exampleCells[0].count, id: \.self) { column in
              let exampleSum = sum(forColumn: column, in: board.exampleCells)
              let userSum = sum(forColumn: column, in: board.userCells)
              SumView(number: exampleSum)
                .foregroundColor(exampleSum == userSum ? Color("correctSumColor") : Color("uncorrectSumColor"))
                .accessibilityLabel("Column \(column + 1) sum: \(exampleSum)")
                .accessibilityHint(exampleSum == userSum ? "Correct" : "Incorrect")
            }
          }
        }
        .padding(.horizontal)

        Spacer()

        HStack {
          ForEach(1..<10) { i in
            Button {
              board.enter(i)
            } label: {
              Image(systemName: "\(i).circle")
                .resizable()
                .scaledToFit()
                .foregroundColor(Color("textColor"))
            }
            .buttonStyle(KeypadGrowingButton())
            .accessibilityLabel("Enter\(i)")
            .accessibilityHint(board.hint(for: i))
            .frame(maxWidth: .infinity)
            .font(.largeTitle)
          }
        }
        .padding()

        Button("Submit") {
          isGameOver = true
          self.timer.upstream.connect().cancel()
        }
        .buttonStyle(MainGrowingButton())
        .disabled(board.isSolved == false)

        Spacer()
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
      .onReceive(timer) { _ in
        if time == 0 {
          self.timer.upstream.connect().cancel()
          isGameOver = true
        } else {
          time -= 1
        }
      }
      .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
      .navigationBarBackButtonHidden(true)
      .navigationBarItems(leading:
                            Button(action: {
        dismiss()
      }) {
        Text("Go Back")
      }
        .buttonStyle(MainGrowingButton())
      )
    }
  }

  //MARK: - View Methods

  func sum(forRow row: [Int]) -> Int {
    row.reduce(0, +)
  }

  func sum(forColumn column: Int, in cells: [[Int]]) -> Int {
    cells.reduce(0) { $0 + $1[column] }
  }

  func startGame(_ diffculty: Difficulty) {
    timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    switch diffculty {
    case .easy:
      time = 60
    case .medium:
      time = 120
    case .tricky:
      time = 180
    case .taxing:
      time = 240
    case .nightmare:
      time = 480
    }
    isGameOver = false
    board.create(diffculty)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    GameView()
  }
}
