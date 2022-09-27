//
//  RealmManager.swift
//  WorkoutDietDiary
//
//  Created by Анатолий Силиверстов on 19.09.2022.
//

import Foundation
import RealmSwift
import CloudKit

class RealmManager: ObservableObject {
    private(set) var localRealm: Realm?
    @Published private(set) var workouts = RealmSwift.List<Workout>()
    @Published private(set) var choosenExercises = RealmSwift.List<ChoosenExercise>()
    @Published private(set) var sets = RealmSwift.List<Set>()
    @Published private(set) var selfExercises = RealmSwift.List<SelfExercise>()
    @Published private(set) var foods = RealmSwift.List<Food>()
    @Published private(set) var days = RealmSwift.List<Day>()
    
    init() {
        openRealm()
        getWorkouts()
    }
    
    func openRealm() {
        do {
            let config = Realm.Configuration(schemaVersion: 1) { migration, oldSchemaVersion in

            }
            Realm.Configuration.defaultConfiguration = config
            localRealm = try Realm()
            getWorkouts()
            getDays()
        } catch {
            print(error)
        }
    }
    
    //MARK: - Workout
    
    func getWorkouts() {
        if let localRealm = localRealm {
            let allWorkouts = localRealm.objects(Workout.self).sorted(byKeyPath: "date")
            workouts.removeAll()
            allWorkouts.forEach { workout in
                workouts.append(workout)
            }
        }
    }
    
    func addWorkout(date: Date, exerciseGroups: [String], choosenExercises: [ChoosenExercise]) {
        if let localRealm = localRealm {
            
        do {
            try localRealm.write {
                let newWorkout = Workout(value: ["date" : date, "exerciseGroups": exerciseGroups, "choosenExercises": choosenExercises ])
                localRealm.add(newWorkout)
                }
            } catch {
                print(error)
            }
        }
    }
    
    func updateWorkout(id: ObjectId, date: Date, exerciseGroups: [String], choosenExercises: [ChoosenExercise]) {
        if let localRealm = localRealm {
            do {
                let workoutToUpdate = localRealm.objects(Workout.self).filter(NSPredicate(format: "id == %@", id))
                guard !workoutToUpdate.isEmpty else {return}
                
                try localRealm.write {
                    workoutToUpdate[0].date = date
                    exerciseGroups.forEach { group in
                        if !workoutToUpdate[0].exerciseGroups.contains(group) {
                            workoutToUpdate[0].exerciseGroups.append(objectsIn: exerciseGroups)
                        }
                    }
                    workoutToUpdate[0].choosenExercises.append(objectsIn: choosenExercises)
                    getWorkouts()
                }
            } catch  {
                print(error)
            }
        }
    }
    
    func deleteWorkout(id: ObjectId) {
        if let localRealm = localRealm {
            do {
                let workoutToDelete = localRealm.objects(Workout.self).filter(NSPredicate(format: "id == %@", id))
                guard !workoutToDelete.isEmpty else {return}
                try localRealm.write {
                    workoutToDelete.forEach { workout in
                        workout.choosenExercises.forEach { exercise in
                            exercise.sets.forEach { setToDelete in
                                localRealm.delete(setToDelete)
                            }
                            localRealm.delete(exercise)
                        }
                    }
                    localRealm.delete(workoutToDelete)
                    getWorkouts()
                }
            } catch  {
                print(error)
            }
        }
    }
    
    //MARK: - ChoosenExercise
    func getChoosenExercises() {
        if let localRealm = localRealm {
            let allChoosenExercises = localRealm.objects(ChoosenExercise.self).sorted(byKeyPath: "icon")
            choosenExercises.removeAll()
            allChoosenExercises.forEach { exercise in
                choosenExercises.append(exercise)
            }
        }
    }
    
    func addChoosenExercise(icon: String, title: String, note: String, date: Date, sets: List<Set>) {
        if let localRealm = localRealm {

        do {
            try localRealm.write {
                let newChoosenExercise = ChoosenExercise(value: ["icon" : icon, "title": title, "note": note, "date": date, "sets": sets])
                localRealm.add(newChoosenExercise)
                print(newChoosenExercise)
                }
            } catch {
                print(error)
            }
        }
    }
    
    func deleteChoosenExercise(id: ObjectId) {
        if let localRealm = localRealm {
            do {
                let choosenExerciseToDelete = localRealm.objects(ChoosenExercise.self).filter(NSPredicate(format: "id == %@", id))
                guard !choosenExerciseToDelete.isEmpty else {return}
                
                try localRealm.write {
                    choosenExerciseToDelete.forEach { exercise in
                        exercise.sets.forEach { setToDelete in
                            localRealm.delete(setToDelete)
                        }
                        localRealm.delete(exercise)
                    }
                    getChoosenExercises()
                }
            } catch  {
                print(error)
            }
        }
    }
    
    //MARK: - Sets
    func getSets() {
        if let localRealm = localRealm {
            let allSets = localRealm.objects(Set.self).sorted(byKeyPath: "id")
            sets.removeAll()
            allSets.forEach { sett in
                sets.append(sett)
            }
        }
    }
    
    
    func addSet(id: ObjectId) {
        if let localRealm = localRealm {
            do {
                let choosenExerciseToUpdate = localRealm.objects(ChoosenExercise.self).filter(NSPredicate(format: "id == %@", id))
                guard !choosenExerciseToUpdate.isEmpty else {return}
                
                try localRealm.write {
                    let set = Set(id: choosenExerciseToUpdate[0].sets.count + 1, repeats: "", weight: "")
                    localRealm.add(set)
                    choosenExerciseToUpdate[0].sets.append(set)
                    getChoosenExercises()
                }
            } catch  {
                print(error)
            }
        }
    }
    
    func deleteLastSetFrom(choosenExerciseId: ObjectId) {
        if let localRealm = localRealm {
            do {
                let exerciseToUpdate = localRealm.objects(ChoosenExercise.self).filter(NSPredicate(format: "id == %@", choosenExerciseId))
                guard !exerciseToUpdate.isEmpty else {return}
                
                try localRealm.write {
                    guard let setToDelete = exerciseToUpdate[0].sets.last else {return}
                    localRealm.delete(setToDelete)
                    
                    getChoosenExercises()
                }
            } catch  {
                print(error)
            }
        }
    }
    
    func deleteAllSets(choosenExerciseId: ObjectId) {
        if let localRealm = localRealm {
            do {
                let exerciseToUpdate = localRealm.objects(ChoosenExercise.self).filter(NSPredicate(format: "id == %@", choosenExerciseId))
                guard !exerciseToUpdate.isEmpty else {return}
                
                try localRealm.write {
                    exerciseToUpdate[0].sets.forEach { setToDelete in
                        
                        localRealm.delete(setToDelete)
                    }
                    
                    getChoosenExercises()
                }
            } catch  {
                print(error)
            }
        }
    }
    

    
    //MARK: - Self Exercises
    
    func addSelfExercise(title: String, exerciseGroup: String) {
        if let localRealm = localRealm {
            
        do {
            try localRealm.write {
                let newExercise = SelfExercise(title: title, exerciseGroup: exerciseGroup)
                localRealm.add(newExercise)
                }
            } catch {
                print(error)
            }
        }
    }
    
    func deleteSelfExercise(id: ObjectId) {
        if let localRealm = localRealm {
            do {
                let exerciseToDelete = localRealm.objects(SelfExercise.self).filter(NSPredicate(format: "id == %@", id))
                guard !exerciseToDelete.isEmpty else {return}
                
                try localRealm.write {
                    localRealm.delete(exerciseToDelete)
                }
            } catch  {
                print(error)
            }
        }
    }
    
    //MARK: - Food
    
    func getFoods() {
        if let localRealm = localRealm {
            let allFood = localRealm.objects(Food.self).sorted(byKeyPath: "date")
            foods.removeAll()
            allFood.forEach { food in
                foods.append(food)
            }
        }
    }
    
    func addFood(name: String, calories: Double) {
        if let localRealm = localRealm {
            
        do {
            try localRealm.write {
                let newFood = Food(value: ["name" : name, "calories": calories ])
                localRealm.add(newFood)
                }
            } catch {
                print(error)
            }
        }
    }
    
    func deleteFood(id: ObjectId) {
        if let localRealm = localRealm {
            do {
                let foodToDelete = localRealm.objects(Food.self).filter(NSPredicate(format: "id == %@", id))
                guard !foodToDelete.isEmpty else {return}
                
                try localRealm.write {
                    localRealm.delete(foodToDelete)
                    getFoods()
                }
            } catch  {
                print(error)
            }
        }
    }
    
    func editFood(id: ObjectId, name: String, calories: Double) {
        if let localRealm = localRealm {
            do {
                let foodToUpdate = localRealm.objects(Food.self).filter(NSPredicate(format: "id == %@", id))
                guard !foodToUpdate.isEmpty else {return}
                
                try localRealm.write {
                    foodToUpdate[0].name = name
                    foodToUpdate[0].calories = calories
                    getFoods()
                }
            } catch  {
                print(error)
            }
        }
    }
    
    //MARK: - Day
    func getDays() {
        if let localRealm = localRealm {
            let alldays = localRealm.objects(Day.self).sorted(byKeyPath: "date")
            days.removeAll()
            alldays.forEach { day in
                days.append(day)
            }
        }
    }
    
    func addDay(day: Day) {
        if let localRealm = localRealm {
            
            do {
                try localRealm.write {
                    let calories = day.foods.reduce(0) { $0 + $1.calories }
                    let newDay = Day(value: ["date": day.date, "calories": calories, "foods": day.foods])
                    localRealm.add(newDay)
                }
            } catch {
                print(error)
            }
        }
    }
    
    func deleteDay(id: ObjectId) {
        if let localRealm = localRealm {
            do {
                let dayToDelete = localRealm.objects(Day.self).filter(NSPredicate(format: "id == %@", id))
                guard !dayToDelete.isEmpty else {return}
                
                try localRealm.write {
                    dayToDelete.forEach { day in
                        day.foods.forEach { food in
                            localRealm.delete(food)
                        }
                        localRealm.delete(day)
                    }
                    getDays()
                }
            } catch  {
                print(error)
            }
        }
    }
    
    func addFoodInDay(id: ObjectId, food: Food) {
        if let localRealm = localRealm {
            do {
                let dayToUpdate = localRealm.objects(Day.self).filter(NSPredicate(format: "id == %@", id))
                guard !dayToUpdate.isEmpty else {return}
                
                try localRealm.write {
                    dayToUpdate[0].foods.append(food)
                    let calories = dayToUpdate[0].foods.reduce(0) { $0 + $1.calories }
                    dayToUpdate[0].calories = calories
//                    getDays()
                }
            } catch  {
                print(error)
            }
        }
    }
    
    func updateCaloriesInDay(id: ObjectId) {
        if let localRealm = localRealm {
            do {
                let dayToUpdate = localRealm.objects(Day.self).filter(NSPredicate(format: "id == %@", id))
                guard !dayToUpdate.isEmpty else {return}
                
                try localRealm.write {
                    let calories = dayToUpdate[0].foods.reduce(0) { $0 + $1.calories }
                    dayToUpdate[0].calories = calories
                }
//                getDays()
            } catch  {
                print(error)
            }
        }
    }
}
