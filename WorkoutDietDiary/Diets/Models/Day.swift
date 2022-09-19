//
//  Day.swift
//  WorkoutDietDiary
//
//  Created by Анатолий Силиверстов on 19.09.2022.
//

import Foundation
import RealmSwift

class Day: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var date: Date
    @Persisted var foods: List<Food>
    @Persisted var calories: Double
    
    convenience init(date: Date, foods: List<Food>, calories: Double) {
        self.init()
        self.date = date
        self.foods = foods
        self.calories = calories
    }
}

class Food: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    @Persisted var calories: Double
    @Persisted var date: Date
    @Persisted(originProperty: "foods") var day: LinkingObjects<Day>
    
    convenience init(name: String, calories: Double, date: Date) {
        self.init()
        self.name = name
        self.calories = calories
        self.date = date
    }
}
