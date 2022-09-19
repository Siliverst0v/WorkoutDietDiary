//
//  DietDiaryView.swift
//  WorkoutDietDiary
//
//  Created by Анатолий Силиверстов on 19.09.2022.
//

import SwiftUI
import RealmSwift

struct DietDiaryView: View {
    @StateObject var realmManager = RealmManager()
    @ObservedResults(Day.self) var days
    @State private var showingCaloriesView = false
    
    var body: some View {
        ScrollView {
            
            Button { showingCaloriesView.toggle() } label: {
                ZStack {
                    Text("Добавить день")
                        .font(.headline)
                    .foregroundColor(.customRed)
                }
                .frame(width: UIScreen.main.bounds.size.width - 40, height: 90, alignment: .center)
            }
            .padding(.horizontal)
            .buttonStyle(WorkoutButtonStyle())
            .sheet(isPresented: $showingCaloriesView) {
                CaloriesView(day: Day())
            }

            ForEach(days, id: \.id) { day in
                Button { showingCaloriesView.toggle() } label: {
                    ZStack {
                        HStack {
                            Spacer()
                            Image("Food")
                                .resizable()
                                .frame(width: 50, height: 50)
                            Text("\(Int(day.calories)) Калорий")
                                .foregroundColor(.customRed)
                                .font(.headline)
                                .frame(width: 110)
                            Spacer()
                            Text("\(dateFormat(date: day.date))")
                                .foregroundColor(.customBlue)
                                .font(.headline)
                                .frame(width: 100)
                            Spacer()
                        }
                    }
                    .frame(width: UIScreen.main.bounds.size.width - 40, height: 90, alignment: .center)
                }
                .padding(.horizontal)
                .buttonStyle(WorkoutButtonStyle())
                .sheet(isPresented: $showingCaloriesView) {
                    CaloriesView(day: day)
                }
            }
        }
    }
}

extension DietDiaryView {
    private func dateFormat(date: Date) -> String {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yyyy"
        return df.string(from: date)
    }
}

struct DietDiaryView_Previews: PreviewProvider {
    static var previews: some View {
        DietDiaryView()
            .environmentObject(RealmManager())
    }
}
