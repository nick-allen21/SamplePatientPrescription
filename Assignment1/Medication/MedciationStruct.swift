//
//  MedciationStruct.swift
//  Assignment1
//
//  Created by Nick Allen on 1/20/25.
//

import SwiftUI

// Medication Struct
// Used to define a Medication Given to a Patient
struct Medication : Hashable{
    // Defining the necessary aspects of the medication struct
    let id : UUID
    let date : Date
    let name : String
    let dose : Double
    let route : Route
    let frequency : Int
    let duration : Int
    let endDate : Date
    
    init(date: Date, name: String, dose: Double, route: Route, frequency: Int, duration: Int, endDate: Date) {
        self.id = UUID()
        self.date = date
        self.name = name
        self.dose = dose
        self.route = route
        self.frequency = frequency
        self.duration = duration
        // safe unwrapping allowing for nil
        // Want to intialize end date to duration after the start date
        self.endDate = Calendar.current.date(byAdding: .day, value: duration, to: date) ?? date
    }
    
    var isCompleted : Bool {
        // if the current date is larger than
        // Computed Property
        Date() > endDate
    }
}
