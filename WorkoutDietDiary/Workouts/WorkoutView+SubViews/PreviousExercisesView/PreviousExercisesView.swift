//
//  PreviousExercisesView.swift
//  WorkoutDietDiary
//
//  Created by Анатолий Силиверстов on 19.09.2022.
//

import SwiftUI

struct PreviousExercisesView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var previousExercises: [ChoosenExercise]
    @Binding var showingSheet: Bool
    
    var body: some View {
        if !previousExercises.isEmpty {
            ScrollView {
                ForEach(previousExercises, id: \.self) {exercise in
                    Text(exercise.date, style: .date)
                        .environment(\.locale, Locale.init(identifier: "ru"))
                        .foregroundColor(.customRed)
                        .font(.headline)
                        .padding(5)
                        .background(
                            RoundedRectangle(cornerRadius: 11)
                                .fill(.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 11)
                                        .stroke(Color.gray, lineWidth: 0.1)
                                )
                        )
                        .padding(.top)
                    PreviousExercisesButton(choosenExercise: exercise)
                        }
                    }
                    .padding()
        } else {
            VStack {
                Spacer()
                Text("Тренировки с таким упражнением не найдены")
                .multilineTextAlignment(.center)
                .foregroundColor(.customRed)
                .font(.title)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 11)
                        .stroke(Color.gray, lineWidth: 0.3)
                )
                Spacer()
            }
        }
    }
}

struct PreviousExercises_Previews: PreviewProvider {
    static var previews: some View {
        PreviousExercisesView(previousExercises: .constant( [Exercises.shared.getMocExercise().choosenExercises.first!]), showingSheet: .constant(true))
    }
}
