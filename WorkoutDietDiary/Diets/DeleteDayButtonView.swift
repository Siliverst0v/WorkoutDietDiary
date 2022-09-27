//
//  DeleteDayButtonView.swift
//  WorkoutDietDiary
//
//  Created by Анатолий Силиверстов on 24.09.2022.
//

import SwiftUI
import RealmSwift

struct DeleteDayButtonView: View {
    
    @EnvironmentObject var realmManager: RealmManager
    @ObservedRealmObject var day: Day
    @State var showConfirm: Bool = false

    
    var body: some View {
        HStack(spacing: 0) {
            Button(action: { showConfirm = true }) {
                Text("x")
                    .foregroundColor(.customRed)
                    .font(.system(size: 20))
            }
            .confirmationDialog("Удалить день?", isPresented: $showConfirm, titleVisibility: .visible, actions: {
                Button("Удалить", role: .destructive) {
                    deleteDay(day: day)
                }
            })
            .buttonStyle(DeleteButtonsStyle())
            .padding(.trailing)
        }
    }
}

extension DeleteDayButtonView {
    
    private func deleteDay(day: Day) {
        realmManager.deleteDay(id: day.id)
    }
}

struct DeleteDayButtonView_Previews: PreviewProvider {
    static var previews: some View {
        DeleteDayButtonView(day: Exercises.shared.getMocDay())
            .environmentObject(RealmManager())
    }
}
