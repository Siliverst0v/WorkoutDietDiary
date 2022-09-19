//
//  ExerciseButtonView.swift
//  WorkoutDietDiary
//
//  Created by Анатолий Силиверстов on 19.09.2022.
//

import SwiftUI

struct ExerciseButton: View {
    @FocusState var isFocused: Bool?

    @State var buttonNotPressed = true
    @State var note: String = "..."
    @State var backgroundHeight: CGFloat = 283
    @State var exerciseAdded = false
    @State var sets: [Set] = [Set(id: 1, repeats: "", weight: ""),
                              Set(id: 2, repeats: "", weight: ""),
                              Set(id: 3, repeats: "", weight: "")]
    
    @Binding var title: String
    @Binding var image: String
    @Binding var choosenExercises: [ChoosenExercise]
    @Binding var date: Date

    
    var body: some View {
        if buttonNotPressed {
                NotPressedButtonView(
                    buttonNotPressed: $buttonNotPressed,
                    exerciseAdded: $exerciseAdded,
                    sets: $sets,
                    choosenExercises: $choosenExercises,
                    date: $date,
                    image: $image,
                    title: $title,
                    note: $note
                )
        } else {
            PressedButtonView(
                isFocused: _isFocused,
                backgroundHeight: $backgroundHeight,
                buttonNotPressed: $buttonNotPressed,
                isExerciseAdded: $exerciseAdded,
                sets: $sets,
                choosenExercises: $choosenExercises,
                date: $date,
                image: $image,
                title: $title,
                note: $note
            )
        }
    }
}

struct ExerciseButton_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseButton(
            title: .constant("Exercise for example"),
            image: .constant("legs"),
            choosenExercises: .constant([]),
            date: .constant(Date()))
        .environmentObject(RealmManager())
    }
}
