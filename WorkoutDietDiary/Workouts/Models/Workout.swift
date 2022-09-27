//
//  Workout.swift
//  WorkoutDietDiary
//
//  Created by Анатолий Силиверстов on 19.09.2022.
//

import Foundation
import RealmSwift

class Workout: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var date: Date
    @Persisted var exerciseGroups: List<String>
    @Persisted var choosenExercises: List<ChoosenExercise>
    
    convenience init(date: Date, exerciseGroups: List<String>, choosenExercises: List<ChoosenExercise>) {
        self.init()
        self.date = date
        self.exerciseGroups = exerciseGroups
        self.choosenExercises = choosenExercises
    }
}

class ChoosenExercise: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var icon: String
    @Persisted var title: String
    @Persisted var note: String
    @Persisted var date: Date
    @Persisted var sets: List<Set>
    @Persisted(originProperty: "choosenExercises") var workout: LinkingObjects<Workout>
    
    convenience init(icon: String, title: String, note: String, date: Date) {
        self.init()
        self.icon = icon
        self.title = title
        self.note = note
        self.date = date
    }
}

class Set: Object, ObjectKeyIdentifiable {
    @Persisted var id: Int
    @Persisted var repeats: String
    @Persisted var weight: String
    @Persisted(originProperty: "sets") var choosenExercises: LinkingObjects<ChoosenExercise>
    
    convenience init(id: Int, repeats: String, weight: String) {
        self.init()
        self.id = id
        self.repeats = repeats
        self.weight = weight
    }
}
