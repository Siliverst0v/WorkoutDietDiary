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
    @Environment(\.dismiss) var dismiss
    var food: Results<Food>.Element
    
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
                        dismiss()
                    }
                    Spacer()
                }
            }
        }
    }
}

struct EditFoodView_Previews: PreviewProvider {
    static var previews: some View {
        EditFoodView( food: Food())
            .environmentObject(RealmManager())
    }
}
