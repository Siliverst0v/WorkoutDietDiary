//
//  SelfExercises.swift
//  WorkoutDietDiary
//
//  Created by Анатолий Силиверстов on 19.09.2022.
//

import Foundation
import RealmSwift

class SelfExercise: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var exerciseGroup: String
    
    convenience init(title: String, exerciseGroup: String) {
        self.init()
        self.title = title
        self.exerciseGroup = exerciseGroup
    }
}
