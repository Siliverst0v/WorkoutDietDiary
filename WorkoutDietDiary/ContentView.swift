//
//  ContentView.swift
//  WorkoutDietDiary
//
//  Created by Анатолий Силиверстов on 19.09.2022.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            WorkoutsView()
                .tabItem {
                    Image(systemName: "stopwatch")
                    Text("Дневник тренировок")
                }
            DietDiaryView()
                .tabItem {
                    Image(systemName: "fork.knife.circle.fill")
                    Text("Дневник калорий")
                    
                }
        }
        .accentColor(.customBlue)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
