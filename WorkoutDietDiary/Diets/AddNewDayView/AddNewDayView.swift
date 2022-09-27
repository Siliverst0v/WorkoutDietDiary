//
//  AddDayView.swift
//  WorkoutDietDiary
//
//  Created by Анатолий Силиверстов on 22.09.2022.
//

import SwiftUI

struct AddNewDayView: View {
    @EnvironmentObject var realmManager: RealmManager
    @Environment(\.dismiss) var dismiss
    @State private var day = Day()
//    @State private var foods: [Food] = []
    @State private var showingAddView = false
    
    var body: some View {
        VStack(alignment: .center) {
            
            DatePicker("Дата", selection: $day.date, displayedComponents: .date)
                .id(day.date)
                .environment(\.locale, Locale.init(identifier: "ru"))
                .datePickerStyle(.compact)
                .foregroundColor(.customRed)
                .font(.headline)
                .padding(5)
                .overlay(
                    RoundedRectangle(cornerRadius: 11)
                        .stroke(Color.gray, lineWidth: 0.3)
                )
                .frame(width: UIScreen.main.bounds.size.width - 40)
            Text("\(Int(totalCaloriesToday())) Ккал за день")
                .foregroundColor(.customRed)
                .font(.headline)
                .padding(.horizontal)
            List {
                ForEach(day.foods, id: \.id) { food in
                    NavigationLink(destination: EditFoodInNewDay( food: food)) {
                        HStack {
                            VStack(alignment: .leading, spacing: 6) {
                                Text(food.name)
                                    .bold()
                                
                                Text("\(Int(food.calories))") +
                                Text(" калорий")
                                    .foregroundColor(Color.customRed)
                            }
                            Spacer()
                        }
                    }
                }
                .onDelete(perform: deleteFood)
            }
            .foregroundColor(.customBlue)
            .listStyle(.plain)
            Button { saveNewDay() } label: {
                ZStack {
                    Text("Добавить день")
                        .foregroundColor(.customRed)
                        .font(.headline)
                        .background(
                            RoundedRectangle(cornerRadius: 11)
                                .fill(.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 11)
                                        .stroke(Color.black, lineWidth: 0.2)
                                )
                                .frame(width: UIScreen.main.bounds.size.width - 40, height: 70, alignment: .center)
                        )
                }
            }
            .offset(x: 0, y: -60)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showingAddView.toggle()
                } label: {
                    Image(systemName: "plus.circle")
                }
            }
        }
        .sheet(isPresented: $showingAddView) {
            AddFoodToNewDayView(day: $day)
        }
    }
}

extension AddNewDayView {
    
    private func totalCaloriesToday() -> Double {
        return day.foods.reduce(0) { $0 + $1.calories }
    }
    
    private func saveNewDay() {
//        day.foods.append(objectsIn: foods)
        day.calories = day.foods.reduce(0) { $0 + $1.calories }
        
        realmManager.addDay(day: day)
        dismiss()
    }
    
    private func deleteFood(offSets: IndexSet) {
        offSets.forEach { index in
            day.foods.remove(at: index)
        }
    }
}

struct AddDayView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewDayView()
    }
}
