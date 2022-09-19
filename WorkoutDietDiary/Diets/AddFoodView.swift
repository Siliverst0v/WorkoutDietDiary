//
//  AddFoodView.swift
//  WorkoutDietDiary
//
//  Created by Анатолий Силиверстов on 19.09.2022.
//

import SwiftUI

struct AddFoodView: View {
    @EnvironmentObject var realmManager: RealmManager
    @Environment(\.dismiss) var dismiss
    
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
                        realmManager.addFood(name: name, calories: calories)
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
        AddFoodView()
    }
}
