//
//  SelfExerciseButton.swift
//  WorkoutDietDiary
//
//  Created by Анатолий Силиверстов on 19.09.2022.
//

import SwiftUI
import RealmSwift

struct SelfExerciseButton: View {
    @ObservedRealmObject var selfExercise: SelfExercise
    @FocusState var isFocused: Bool?

    @State var buttonNotPressed = true
    @State var note: String = "..."
    @State var backgroundHeight: CGFloat = 283
    @State var exerciseAdded = false
    @State var sets: [Set] = [Set(id: 1, repeats: "", weight: ""),
                              Set(id: 2, repeats: "", weight: ""),
                              Set(id: 3, repeats: "", weight: "")]
    
    @Binding var image: String
    @Binding var choosenExercises: [ChoosenExercise]
    @Binding var date: Date

    
    var body: some View {
        if buttonNotPressed {
            NotPressedSelfExerciseButton(
                    selfExercise: selfExercise,
                    buttonNotPressed: $buttonNotPressed,
                    exerciseAdded: $exerciseAdded,
                    sets: $sets,
                    choosenExercises: $choosenExercises,
                    date: $date,
                    image: $image,
                    note: $note
                )
            .environmentObject(RealmManager())
        } else {
            PressedSelfExerciseButton(
                isFocused: _isFocused,
                selfExercise: selfExercise,
                backgroundHeight: $backgroundHeight,
                buttonNotPressed: $buttonNotPressed,
                isExerciseAdded: $exerciseAdded,
                sets: $sets,
                choosenExercises: $choosenExercises,
                date: $date,
                image: $image,
                note: $note
            )
            .environmentObject(RealmManager())
        }
    }
}

struct SelfExerciseButton_Previews: PreviewProvider {
    static var previews: some View {
        SelfExerciseButton(
            selfExercise: SelfExercise(title: "Добавить упражнение", exerciseGroup: "Ноги"),
            image: .constant("legs"),
            choosenExercises: .constant([]),
            date: .constant(Date()))
        .environmentObject(RealmManager())
    }
}
