//
//  SumView.swift
//  WrongSudoku
//
//  Created by Николай Никитин on 09.12.2022.
//

import SwiftUI

struct SumView: View {

  var number: Int
  @ScaledMetric(relativeTo: .title) var frameWidth = 50


    var body: some View {
        Text(String(number))
        .font(.title)
        .monospacedDigit()
        .frame(width: frameWidth, height: frameWidth)
    }
}

struct SumView_Previews: PreviewProvider {
    static var previews: some View {
      SumView(number: 9)
    }
}
