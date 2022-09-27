//
//  EditFoodView.swift
//  WorkoutDietDiary
//
//  Created by Анатолий Силиверстов on 19.09.2022.
//

import SwiftUI
import RealmSwift

struct EditFoodView: View {
    
    @EnvironmentObject var realmManager: RealmManager
    @ObservedRealmObject var day: Day
    @ObservedRealmObject var food: Food
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var calories: Double = 0
    
    var body: some View {
        Form {
            Section {
                TextField("\(food.name)", text: $name)
                    .onAppear {
                        name = food.name
                        calories = food.calories
                    }
                VStack {
                    Text("Калории: \(Int(calories))")
                    Slider(value: $calories, in: 0...2000, step: 10)
                }
                .padding()
                
                HStack {
                    Spacer()
                    Button("Изменить") {
                        realmManager.editFood(id: food.id, name: name, calories: calories)
                        realmManager.updateCaloriesInDay(id: day.id)
                        dismiss()
                    }
                    Spacer()
                }
            }
        }
    }
}

extension EditFoodView {
//    private func editFoodInDay() {
//        if var editFood = day.foods.first(where: { $0.id == food.id }) {
//            editFood = food
//        }
//        realmManager.updateDay(id: day.id, date: day.date, foods: day.foods, calories: day.calories)
//
//        dismiss()
//    }
}

struct EditFoodView_Previews: PreviewProvider {
    static var previews: some View {
        EditFoodView( day: Exercises.shared.getMocDay(), food: Food())
            .environmentObject(RealmManager())
    }
}
