//
//  NotPressedSelfExerciseButton.swift
//  WorkoutDietDiary
//
//  Created by Анатолий Силиверстов on 19.09.2022.
//

import SwiftUI
import RealmSwift

struct NotPressedSelfExerciseButton: View {
    @ObservedRealmObject var selfExercise: SelfExercise
    
    @Binding var buttonNotPressed: Bool
    @Binding var exerciseAdded: Bool
    @Binding var sets: [Set]
    @Binding var choosenExercises: [ChoosenExercise]
    @Binding var date: Date
    
    @Binding var image: String
    @Binding var note: String
    
    let buttonWidth = UIScreen.main.bounds.size.width - 40
    
    var body: some View {
        ZStack{
            Button( action: { buttonNotPressed.toggle() } ) {
                HStack {
                    Spacer()
                    Image(image)
                        .resizable()
                        .frame(width: 70, height: 40)
                    Spacer()
                    Text(selfExercise.title)
                        .fontWeight(.semibold)
                        .lineLimit(3)
                        .frame(width: buttonWidth - 140,
                               height: 70,
                               alignment: .leading)
                    Spacer()
                    Button(action: { addExercise() }) {
                        Image(systemName: exerciseAdded ? "checkmark.square" : "square")
                            .font(.system(size: 20))
                            .foregroundColor(.customBlue)
                            .frame(width: 40,
                                   height: 40,
                                   alignment: .center)
                    }
                    Spacer()
                }
            }
            .buttonStyle(ExerciseButtonStyle())
        }
    }
    
}

extension NotPressedSelfExerciseButton {
    func addExercise() {
        exerciseAdded.toggle()
        
        let choosenExercise = ChoosenExercise(
            icon: image,
            title: selfExercise.title,
            note: note,
            date: date)
        
        sets.forEach { sett in
            choosenExercise.sets.append(
                Set(
                    id: sett.id,
                    repeats: sett.repeats,
                    weight: sett.weight))
        }
        
        if exerciseAdded {
            choosenExercises.append(choosenExercise)
        } else {
            choosenExercises.removeAll(where: {$0.title == choosenExercise.title})
        }
    }
}

struct NotPressedSelfExerciseButton_Previews: PreviewProvider {
    static var previews: some View {
        NotPressedSelfExerciseButton(
            selfExercise: SelfExercise(title: "Жим гантелей на наклонной скамье", exerciseGroup: "Грудь"),
            buttonNotPressed: .constant(true),
            exerciseAdded: .constant(true),
            sets: .constant([
                Set(id: 1, repeats: "", weight: ""),
                Set(id: 2, repeats: "", weight: ""),
                Set(id: 3, repeats: "", weight: "")]),
            choosenExercises: .constant([]),
            date: .constant(Date()),
            image: .constant("chest"),
            note: .constant("...")
        )
        .environmentObject(RealmManager())
    }
}
