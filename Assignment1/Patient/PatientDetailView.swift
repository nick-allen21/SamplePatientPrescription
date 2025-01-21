//
//  PatientDetailView.swift
//  Assignment1
//
//  Created by Nick Allen on 1/20/25.
//

import SwiftUI

// Used to define the detailed patient array for our selected patient
struct DetailedPatientView: View {
    @Binding var selectedPatient: Patient
    @Binding var medications: [Medication]

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                // Group Box organizes the information well
                // Chose to split into medications and patient info
                GroupBox(label: Text("Patient Information").font(.headline)) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Name: \(selectedPatient.name)")
                        Text("Surname: \(selectedPatient.surname)")
                        Text("MRN: \(selectedPatient.MRN)")
                        Text("Age: \(selectedPatient.age)")
                        Text("DOB: \(selectedPatient.DOB, format: .dateTime.year().month().day())")
                        Text("Height: \(selectedPatient.height)")
                        Text("Weight: \(selectedPatient.weight)")
                        if let bloodType = selectedPatient.bloodType {
                            Text("Blood Type: \(bloodType)")
                        }
                    }
                    .padding(.vertical, 8)
                }
                
                GroupBox(label: Text("Medications").font(.headline)) {
                    VStack(alignment: .leading, spacing : 8) {
                        if selectedPatient.medications.isEmpty {
                                    Text("No medications prescribed.")
                        } else {
                            ForEach(selectedPatient.medications, id: \.self) { medication in
                                Text(medication.name)
                            }
                        }
                    }
                    .padding(.vertical, 8)
                }
                
                Spacer()
                
                VStack(spacing: 12) {
                    // The first button is to create a new medication in the medications array
                    NavigationLink("Create New Medication") {
                        CreateMedicationForm(medications: $medications)
                    }
                    .padding()
                    .background(Color(.systemGray6)) // Light background color
                    .cornerRadius(12) // Rounded corners
                    .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 2)
                    
                    // This button can prescibe an existing medication to an individual
                    NavigationLink("Prescribe Existing Medication To Patient") {
                        PrescribeMedicationForm(medications: $medications, selectedPatient: $selectedPatient)
                    }
                    .padding()
                    .background(Color(.systemGray6)) // Light background color
                    .cornerRadius(12) // Rounded corners
                    .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 2)
                }
            }
            .padding()
            .navigationTitle("Patient Details")
        }
    }
}

#Preview {
    let patient_1 = Patient(name: "Nick", surname: "Allen", DOB: Calendar.current.date(byAdding: .year, value: -45, to: now)!, height: 60.0, weight: 210.0, bloodType: .APos, medications: medications)
    let medications_1 = [
        Medication(date: now, name: "Ozempic", dose: 0.5, route: .subcutaneous, frequency: 1, duration: 30, endDate: now.addingTimeInterval(30 * 24 * 60 * 60)),
        Medication(date: now, name: "Amoxicillin", dose: 500, route: .oral, frequency: 2, duration: 7, endDate: now.addingTimeInterval(7 * 24 * 60 * 60)),
        Medication(date: now, name: "Levothyroxine", dose: 75, route: .oral, frequency: 1, duration: 90, endDate: now.addingTimeInterval(90 * 24 * 60 * 60))
    ]
    DetailedPatientView(selectedPatient : .constant(patient_1), medications : .constant(medications_1))
}
