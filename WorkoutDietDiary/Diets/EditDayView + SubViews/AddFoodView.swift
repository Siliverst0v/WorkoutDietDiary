//
//  AddFoodView.swift
//  WorkoutDietDiary
//
//  Created by Анатолий Силиверстов on 19.09.2022.
//

import SwiftUI
import RealmSwift

struct AddFoodView: View {
    @EnvironmentObject var realmManager: RealmManager
    @Environment(\.dismiss) var dismiss
    @ObservedRealmObject var day: Day
    @State private var name = ""
    @State private var calories: Double = 0
    
    var newDay: Day?
    var body: some View {
        Form {
            Section {
                TextField("Название", text: $name)
                
                VStack {
                    Text("Калории: \(Int(calories))")
                    Slider(value: $calories, in: 0...2000, step: 10)
                }
                .padding()
                
                HStack {
                    Spacer()
                    Button("Добавить") {
                        let food = Food(name: name, calories: calories, date: day.date)
                        realmManager.addFoodInDay(id: day.id, food: food)
                        dismiss()
                    }
                    Spacer()
                }
            }
        }
    }
}

struct AddFoodView_Previews: PreviewProvider {
    static var previews: some View {
        AddFoodView(day: Exercises.shared.getMocDay())
    }
}
