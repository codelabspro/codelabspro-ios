//

import SwiftUI

struct DetailEditView: View {
    @Binding var data:  DailyScrum.Data
    @State private var newAttendeeName = ""
    var body: some View {
        Form {
            Section(header: Text("Meeting Info")) {
                TextField("Title", text: $data.title)
                HStack {
                    Slider(value: $data.lengthInMinutes, in: 5...30, step: 1) {
                        Text("Length")
                        
                        Spacer()
                        
                        Text("\(Int(data.lengthInMinutes)) minutes")
                            .accessibilityHidden(true)
                    }
                    .accessibilityValue("\(Int(data.lengthInMinutes)) minutes")
                }
                ThemePicker(selection: $data.theme)
            }
            
            Section(header: Text("Attendees")) {
                ForEach(data.attendees) { attendee in
                    Text(attendee.name)
                }
                .onDelete { indices in
                    data.attendees.remove(atOffsets: indices)
                    
                }
                
                HStack {
                    TextField("New Attendeed", text: $newAttendeeName)
                    
                    Button(action: {
                        withAnimation {
                            let attendee = DailyScrum.Attendee(name: newAttendeeName)
                            data .attendees.append(attendee)
                            newAttendeeName = ""
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .accessibilityLabel("Add attendee")
                    }
                    .disabled(newAttendeeName.isEmpty)
                }
                
            }
        }
    }
}

struct DetailEditView_Previews: PreviewProvider {
    static var previews: some View {
        DetailEditView(data: .constant(DailyScrum.sampleData[0].data))
    }
}
