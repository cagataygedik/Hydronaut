//
//  Date+IsToday.swift
//  Hydronaut
//
//  Created by Celil Çağatay Gedik on 12.03.2024.
//

import Foundation

extension Date {
  
  func isToday() -> Bool {
    
    let todayComponents = Calendar.current.dateComponents([.year, .month, .day], from: Date())
    let selfComponents = Calendar.current.dateComponents([.year, .month, .day], from: self)
    
    guard todayComponents.year == selfComponents.year else { return false }
    guard todayComponents.month == selfComponents.month else { return false }
    guard todayComponents.day == selfComponents.day else { return false }
    
    return true
  }
}
