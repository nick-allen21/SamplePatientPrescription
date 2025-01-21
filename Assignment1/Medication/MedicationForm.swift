//
//  Untitled.swift
//  Assignment1
//
//  Created by Nick Allen on 1/20/25.
//

// Form for creating a new Medication that we can ascribe to a patient
import SwiftUI

struct CreateMedicationForm: View {
    
    @Binding var medications : [Medication]
    @State private var date = Date()
    @State private var name: String = ""
    @State private var dose: String = ""
    @State private var route: Route = .oral
    @State private var frequency: String = ""
    @State private var duration: String = ""
    @State private var endDate: Date = Date()
    
    // Access the dismiss environment
    @Environment(\.dismiss) private var dismiss
   
    // function for actually adding that medication to the array of existing medications
    private func addMedication() {
        
        let newMedication = Medication(
            date : Date(),
            name: name,
            dose: Double(dose)!,
            route: route,
            frequency: Int(frequency)!,
            duration: Int(duration)!,
            endDate: endDate
        )
        medications.append(newMedication)
        dismiss()
    }
    
    // Querying for information concerning a medication
    var body : some View {
        VStack{
            Form {
                TextField("Medication Name", text: $name)
                
                TextField("Dose (mg)", text: $dose)
                    .keyboardType(.decimalPad)
                
                Picker("Route", selection: $route) {
                    ForEach(Route.allCases, id: \.self) { routeOption in
                        Text(routeOption.rawValue).tag(routeOption)
                    }
                }
                
                TextField("Frequency (per day)", text: $frequency)
                    .keyboardType(.numberPad)
                
                TextField("Duration (days)", text: $duration)
                    .keyboardType(.numberPad)
                }
                
                Spacer()
            
                Button("Create Medication") {
                    addMedication()
                }
                .navigationTitle("Create Patient")
            }
        }
        }

