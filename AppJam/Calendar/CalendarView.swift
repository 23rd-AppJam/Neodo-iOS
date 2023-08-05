import SwiftUI

struct CalendarView: View {
    @State var isPresentedWrite = false
    @State var isCompletToWrite = false
    @State var calendarState = "Prev"
    @State var isPresentedDetail = false

    var body: some View {
        NavigationStack {
            VStack {
                Image("Calendar\(calendarState)")
                    .onTapGesture {
                        if isCompletToWrite {
                            isPresentedDetail = true
                        } else {
                            isPresentedWrite = true
                        }
                    }

                Spacer()
            }
            .fullScreenCover(isPresented: $isPresentedWrite) {
                WriteView()
                    .onDisappear {
                        calendarState = "Next"
                        isCompletToWrite = true
                    }
            }
            .sheet(isPresented: $isPresentedDetail) {
                DetailCalendarView()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("캘린더")
                        .font(.system(size: 22, weight: .bold))
                }
            }
        }
    }
}
