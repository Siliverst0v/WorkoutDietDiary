//
//  Helpers.swift
//  WorkoutDietDiary
//
//  Created by Анатолий Силиверстов on 28.09.2022.
//

import SwiftUI

public let width = UIScreen.main.bounds.size.width - 40

public func adaptiveSystemFont() -> Font {
    if width >= 380 {
        return .system(size: 14)
    } else {
        return .system(size: 12)
    }
}

public func formatDate(date: Date) -> String {
    let df = DateFormatter()
    df.dateFormat = "dd.MM.yyyy"
    return df.string(from: date)
}

public func getDayName(date: Date) -> String {
    let df = DateFormatter()
    df.dateFormat = "EEEE"
    df.locale = Locale(identifier: "ru_RU")
    return df.string(from: date)
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension LinearGradient {
    init(_ colors: Color...) {
        self.init(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}

extension Color {
    static let customBlue = Color(red: 72/255, green: 110/255, blue: 158/255)
    static let customRed = Color(red: 216/255, green: 75/255, blue: 89/255)
}

