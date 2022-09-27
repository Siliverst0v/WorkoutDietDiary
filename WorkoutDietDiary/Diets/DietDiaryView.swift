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
    @ObservedResults(Day.self, sortDescriptor: SortDescriptor(keyPath: "date", ascending: false)) var days
    @State private var dietDiaryIsActive = false
    @State var selection: String? = nil
    @State var daySelection: ObjectId? = ObjectId()
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(days, id: \.id) { day in
                    VStack(alignment: .trailing, spacing: 0) {
                        DeleteDayButtonView(day: day)
                            .environmentObject(realmManager)
                        Button { daySelection = day.id } label: {
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
                                NavigationLink("",
                                               tag: day.id,
                                               selection: $daySelection) {
                                    
                                    CaloriesView(day: day)
                                        .environmentObject(realmManager)
                                }
                            }
                            .frame(
                                width: UIScreen.main.bounds.size.width - 40,
                                height: 90,
                                alignment: .center
                            )
                        }
                        .buttonStyle(WorkoutButtonStyle())
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 5)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dietDiaryIsActive = true
                        self.selection = "CaloriesView"
                        
                    } label: {
                        Image(systemName: "plus.circle")
                        NavigationLink("",
                                       tag: dietDiaryIsActive ? "CaloriesView" : "",
                                       selection: $selection) {
                            AddNewDayView()
                        }
                    }
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
