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
    @ObservedResults(Food.self) var foods
    @ObservedRealmObject var day: Day
    
    // Delete and change on day.date
    @State private var date = Date()
    
    @State private var showingAddView = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                
                DatePicker("Дата", selection: $date, displayedComponents: .date)
                    .id(Date())
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
                        NavigationLink(destination: EditFoodView(food: food)) {
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
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Сохранить")
                    }

                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddView.toggle()
                    } label: {
                        Image(systemName: "plus.circle")
                    }
                }
            }
            .sheet(isPresented: $showingAddView) {
                AddFoodView()
            }
        }
        .navigationViewStyle(.stack)
    }
}

extension CaloriesView {
    private func totalCaloriesToday() -> Double {
        var caloriesToday: Double = 0
        for item in day.foods {
            if Calendar.current.isDateInToday(item.date) {
                caloriesToday += item.calories
            }
        }
        return caloriesToday
    }
    
    private func saveNewDay() {
        realmManager.addDay(day: day)
    }
    
    private func deleteFood(offSets: IndexSet) {
        offSets.forEach { index in
            realmManager.deleteFood(id: foods[index].id)
        }
        realmManager.getFoods()
    }
}

struct CaloriesView_Previews: PreviewProvider {
    static var previews: some View {
        CaloriesView(day: Exercises.shared.getMocDay())
            .environmentObject(RealmManager())
    }
}
