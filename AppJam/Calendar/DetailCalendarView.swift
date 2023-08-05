import SwiftUI

struct DetailCalendarView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("일기")
                .font(.system(size: 22, weight: .semibold))
                .padding(.top, 16)

            Text("오늘의 일기")
                .font(.system(size: 18, weight: .semibold))

            Divider()

            Text("탕수육 맛있다!")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.gray700)

            Spacer()
        }
        .padding(.horizontal, 20)
    }
}
