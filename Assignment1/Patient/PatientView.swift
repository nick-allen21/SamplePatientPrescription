//
//  PatientView.swift
//  Assignment1
//
//  Created by Nick Allen on 1/20/25.
//

import SwiftUI

struct PatientView : View {
    let patient : Patient
    
    var body : some View {
        // Vertical Stack to fit everything
        // In aesthetic manner 
        VStack(alignment: .leading, spacing: 8) {
            Text(patient.name + " " + patient.surname)
                .font(.headline)
            let MRNStr = String("\(patient.MRN)".prefix(6) + "...")
            let ageStr = String(patient.age)
            Text("Age : " + ageStr + ", MRN : " + MRNStr)
                .font(.subheadline)
        }
        .padding() // Add padding inside the container
        .background(Color(.systemGray6)) // Light background color
        .cornerRadius(12) // Rounded corners
        .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 2)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
    }
}

let now = Date()
let medications = [
    Medication(date: now, name: "Ozempic", dose: 0.5, route: .subcutaneous, frequency: 1, duration: 30, endDate: now.addingTimeInterval(30 * 24 * 60 * 60)),
    Medication(date: now, name: "Amoxicillin", dose: 500, route: .oral, frequency: 2, duration: 7, endDate: now.addingTimeInterval(7 * 24 * 60 * 60)),
    Medication(date: now, name: "Levothyroxine", dose: 75, route: .oral, frequency: 1, duration: 90, endDate: now.addingTimeInterval(90 * 24 * 60 * 60))
]

let patient_ = Patient(name: "John", surname: "Doe", DOB: Calendar.current.date(byAdding: .year, value: -45, to: now)!, height: 60.0, weight: 210.0, bloodType: .APos, medications: medications)

#Preview {
    PatientView(patient : patient_)
}

