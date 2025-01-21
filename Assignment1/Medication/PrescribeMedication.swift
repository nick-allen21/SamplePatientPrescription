//
//  Untitled.swift
//  Assignment1
//
//  Created by Nick Allen on 1/20/25.
//

import SwiftUI

struct PrescribeMedicationForm : View {
    
    @Binding var medications : [Medication]
    @Binding var selectedPatient : Patient
    @State var selectedMedication : Medication?
    @State var errorMessage : String?
    @Environment(\.dismiss) private var dismiss
    
    var body : some View{
        Form {
            Section(header : Text("Choose a Medication")) {
                if medications.isEmpty {
                    Text("No medications Have Been Created Yet. Please Create one in the Previous Page.")
                }else{
                    Picker("Select Medication", selection: $selectedMedication) {
                        ForEach(medications, id : \.id) { medication in
                            Text(medication.name)
                            // Medication is optional until we select with the form
                                .tag(Optional(medication))
                        }
                    }
                    .padding()
                    .cornerRadius(12) // Rounded corners
                }
            }
        }
        Button("Prescribe Medication to Patient") {
            do {
                if let medication = selectedMedication {
                    try selectedPatient.prescribe(medication: medication)
                    dismiss()
                // Custom Error Messages for when prescibe doesn't let us
                } else {
                    errorMessage = "Please select a medication."
                }
            } catch Patient.prescriptionError.medicationExists {
                errorMessage = "The selected medication already exists for this patient."
            } catch {
                errorMessage = "An unexpected error occurred. Please try again."
            }
        }
        .padding()
        .background(Color(.systemGray6)) // Light background color
        .cornerRadius(12) // Rounded corners
        .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 2)
        Text(errorMessage ?? "")
        .padding()
    }
}


#Preview {
    let patient_2 = Patient(name: "John", surname: "Doe", DOB: Calendar.current.date(byAdding: .year, value: -45, to: now)!, height: 60.0, weight: 210.0, bloodType: .APos, medications: medications)
    let medications_2 = [
        Medication(date: now, name: "Ozempic", dose: 0.5, route: .subcutaneous, frequency: 1, duration: 30, endDate: now.addingTimeInterval(30 * 24 * 60 * 60)),
        Medication(date: now, name: "Amoxicillin", dose: 500, route: .oral, frequency: 2, duration: 7, endDate: now.addingTimeInterval(7 * 24 * 60 * 60)),
        Medication(date: now, name: "Levothyroxine", dose: 75, route: .oral, frequency: 1, duration: 90, endDate: now.addingTimeInterval(90 * 24 * 60 * 60))
    ]
    
    PrescribeMedicationForm(medications : .constant(medications_2), selectedPatient: .constant(patient_2))
}

