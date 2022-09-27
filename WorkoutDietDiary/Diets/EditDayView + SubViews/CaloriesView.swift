//
//  CaloriesView.swift
//  WorkoutDietDiary
//
//  Created by Анатолий Силиверстов on 19.09.2022.
//

import SwiftUI
import RealmSwift

struct CaloriesView: View {
    @EnvironmentObject var realmManager: RealmManager
    @Environment(\.dismiss) var dismiss
    @ObservedRealmObject var day: Day
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
                    NavigationLink(destination: EditFoodView(day: day, food: food)) {
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
            AddFoodView(day: day)
        }
    }
}

extension CaloriesView {
    
    private func totalCaloriesToday() -> Double {
        return day.foods.reduce(0) { $0 + $1.calories }
    }
    
    private func updateCalories() {
        realmManager.updateCaloriesInDay(id: day.id)
    }
    
    private func deleteFood(offSets: IndexSet) {
        offSets.forEach { index in
            let foodToDelete = day.foods[index]
            realmManager.deleteFood(id: foodToDelete.id)
        }
        realmManager.getFoods()
        realmManager.updateCaloriesInDay(id: day.id)
    }
}

struct CaloriesView_Previews: PreviewProvider {
    static var previews: some View {
        CaloriesView(day: Exercises.shared.getMocDay())
            .environmentObject(RealmManager())
    }
}
