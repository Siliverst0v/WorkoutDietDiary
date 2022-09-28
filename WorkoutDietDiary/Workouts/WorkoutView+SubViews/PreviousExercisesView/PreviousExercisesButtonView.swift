//
//  PreviousExercisesButtonView.swift
//  WorkoutDietDiary
//
//  Created by Анатолий Силиверстов on 19.09.2022.
//

import SwiftUI

struct PreviousExercisesButton: View {
    
    @State private var backgroundHeight: CGFloat = 248
    @State var choosenExercise: ChoosenExercise
    
    var body: some View {
        ZStack(alignment: .top) {
            ExerciseButtonsBackgroundView(
                width: width,
                height: backgroundHeight + CGFloat(((choosenExercise.sets.count - 1) * 46)))
            VStack(alignment: .center) {
                HStack {
                    Spacer()
                    Image(choosenExercise.icon)
                        .resizable()
                        .frame(width: 70, height: 40)
                    Spacer()
                    Text(choosenExercise.title)
                        .fontWeight(.semibold)
                        .font(.system(size: 14))
                        .foregroundColor(.customBlue)
                        .lineLimit(3)
                        .frame(
                            width: width - 92,
                            height: 60,
                            alignment: .leading)
                    Spacer()
                }
                .frame(width: width, height: 70, alignment: .center)
                
                VStack(alignment: .leading) {
                    HStack {
                        Spacer()
                        Text("Подходы")
                            .fontWeight(.semibold)
                            .foregroundColor(.customRed)
                        Spacer()
                        Text("Повторения")
                            .fontWeight(.semibold)
                            .foregroundColor(.customRed)
                        Spacer()
                        Text("Вес/Время")
                            .fontWeight(.semibold)
                            .foregroundColor(.customRed)
                        Spacer()
                    }
                    .font(.system(size: 14))
                    .frame(width: width/1.1)
                    
                    ForEach($choosenExercise.sets, id: \.id) { setNumber in
                        HStack() {
                            Spacer()
                            Text("\(setNumber.id)")
                                .fontWeight(.semibold)
                                .frame(width: 64)
                                .font(.system(size: 17))
                                .foregroundColor(.customBlue)
                            Spacer()
                            TextField("0", text: setNumber.repeats)
                                .disabled(true)
                                .frame(width: 84)
                                .keyboardType(.decimalPad)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            Spacer()
                            TextField("0", text: setNumber.weight)
                                .disabled(true)
                                .frame(width: 76)
                                .keyboardType(.decimalPad)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            Spacer()
                            
                        }
                        .frame(width: width/1.1)
                    }
                }
                
                TextEditor(text: $choosenExercise.note)
                    .disabled(true)
                    .foregroundColor(.customBlue)
                    .lineLimit(2)
                    .frame(width: width - 40, height: 80)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray, lineWidth: 0.3)
                    )
                
            }
        }
    }
}

extension PreviousExercisesButton {
    
    private func changeButtonSize() -> CGFloat {
        var buttonSize: CGFloat = 127
        if choosenExercise.sets.count < 3 && choosenExercise.sets.count > 1 {
            buttonSize = 83
        } else if choosenExercise.sets.count == 1 {
            buttonSize = 44
        }
        return buttonSize
    }
}

struct PreviousExercisesButton_Previews: PreviewProvider {
    static var previews: some View {
        PreviousExercisesButton(choosenExercise: Exercises.shared.getMocExercise().choosenExercises.first!)
    }
}
