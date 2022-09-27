//
//  AddFoodToNewDayView.swift
//  WorkoutDietDiary
//
//  Created by Анатолий Силиверстов on 27.09.2022.
//

import SwiftUI

struct AddFoodToNewDayView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var day: Day
    @State private var name = ""
    @State private var calories: Double = 0
    
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
                        day.foods.append(food)
                        dismiss()
                    }
                    Spacer()
                }
            }
        }
    }
}

struct AddFoodToNewDayView_Previews: PreviewProvider {
    static var previews: some View {
        AddFoodToNewDayView( day: .constant(Exercises.shared.getMocDay()))
    }
}
