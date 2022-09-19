//
//  ExerciseButtonsBackgroundView.swift
//  WorkoutDietDiary
//
//  Created by Анатолий Силиверстов on 19.09.2022.
//

import SwiftUI

struct ExerciseButtonsBackgroundView: View {
    
    let width: CGFloat
    var height: CGFloat
    
    var body: some View {
        RoundedRectangle(cornerRadius: 11)
            .fill(.white)
            .overlay(
                RoundedRectangle(cornerRadius: 11)
                    .stroke(Color.gray, lineWidth: 3)
                    .blur(radius: 10)
                    .offset(x: 5, y: 5)
                    .mask(
                        RoundedRectangle(cornerRadius: 11)
                        .fill(LinearGradient(Color.black, Color.gray)))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 11)
                    .stroke(Color.white, lineWidth: 3)
                    .blur(radius: 10)
                    .offset(x: -5, y: -5)
                    .mask(
                        RoundedRectangle(cornerRadius: 11)
                            .fill(LinearGradient(Color.black, Color.gray)))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 11)
                    .stroke(Color.gray, lineWidth: 0.1)
            )
            .frame(width: width, height: height, alignment: .center)

            
    }
}

struct ExerciseButtonsBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseButtonsBackgroundView(width: UIScreen.main.bounds.size.width - 40, height: 260)
    }
}
