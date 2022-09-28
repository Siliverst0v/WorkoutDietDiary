//
//  NotPressedChoosenExerciseButtonView.swift
//  WorkoutDietDiary
//
//  Created by Анатолий Силиверстов on 19.09.2022.
//

import SwiftUI
import RealmSwift

struct NotPressedChoosenExerciseButtonView: View {
    @EnvironmentObject var realmManager: RealmManager
    @ObservedRealmObject var choosenExercise: ChoosenExercise
    @Binding var buttonNotPressed: Bool
    var icon: String
    var title: String
    
    @Binding var showConfirm: Bool
    
    var body: some View {
        ZStack{
            Button( action: { buttonNotPressed.toggle() } ) {
                HStack {
                    Spacer()
                    Image(icon)
                        .resizable()
                        .frame(width: 70, height: 40)
                    Spacer()
                    Text(title)
                        .fontWeight(.semibold)
                        .lineLimit(3)
                        .frame(
                            width: width - 140,
                            height: 70,
                            alignment: .leading)
                    Spacer()
                    Button(action: { showConfirm = true }) {
                        Image(systemName: "trash")
                            .font(.system(size: 20))
                            .foregroundColor(.customRed)
                            .frame(width: 40,
                                   height: 40,
                                   alignment: .center)
                    }
                    .opacity(0)
                    .disabled(true)
                    Spacer()
                }
                .frame(width: width, height: 70, alignment: .center)
            }
            .buttonStyle(ExerciseButtonStyle())
        }
    }
}

struct NotPressedChoosenExerciseButtonView_Previews: PreviewProvider {
    static var previews: some View {
        NotPressedChoosenExerciseButtonView(
            choosenExercise: ChoosenExercise(icon: "chest", title: "Жим гантелей на наклонной скамье", note: "", date: Date()),
            buttonNotPressed: .constant(false),
            icon: "chest",
            title: "Exercise for example",
            showConfirm: .constant(false))
    }
}
