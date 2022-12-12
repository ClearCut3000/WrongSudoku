//
//  ButtonStyle.swift
//  WrongSudoku
//
//  Created by Николай Никитин on 12.12.2022.
//

import SwiftUI

struct MainGrowingButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color("uncorrectSumColor"))
            .foregroundColor(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.5 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
