//
//  ExerciseGroup.swift
//  WorkoutDietDiary
//
//  Created by Анатолий Силиверстов on 19.09.2022.
//

import Foundation

struct ExerciseGroup: Identifiable, Equatable, Hashable {
    let id = UUID()
    var title: String
    var icon: String
    var exercisesToDisplay: [String]
}

extension ExerciseGroup {
    static func getChoosenExercise() -> ChoosenExercise {
        return ChoosenExercise(icon: "chest", title: "Жим гантелей на наклонной скамье", note: "", date: Date())
    }
    
    static func getMocExercises() -> [ExerciseGroup] {
        return [
            ExerciseGroup(
                title: "Грудь",
                icon: "chest",
                exercisesToDisplay: Exercises.shared.chest
            ),
            ExerciseGroup(
                title: "Спина",
                icon: "back",
                exercisesToDisplay: Exercises.shared.back
            )
        ]
    }
}
