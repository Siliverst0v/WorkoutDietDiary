//
//  EditFoodInNewDay.swift
//  WorkoutDietDiary
//
//  Created by Анатолий Силиверстов on 27.09.2022.
//

import SwiftUI

struct EditFoodInNewDay: View {
    
    @EnvironmentObject var realmManager: RealmManager
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var calories: Double = 0
    
    var food: Food
    
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
                        food.name = name
                        food.calories = calories
                        dismiss()
                    }
                    Spacer()
                }
            }
        }
    }
}

struct EditFoodInNewDay_Previews: PreviewProvider {
    static var previews: some View {
        EditFoodInNewDay(food: Food())
    }
}
