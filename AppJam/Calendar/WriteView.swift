import SwiftUI

struct WriteView: View {
    @Environment(\.dismiss) var dismiss
    @State var title = ""
    @State var description = ""
    @FocusState var titleFocusState: Bool
    @FocusState var descriptionFocusState: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("일기 작성")
                .font(.system(size: 22, weight: .semibold))
                .padding(.top, 16)

            HStack {
                TextField("제목", text: $title)
                    .focused($titleFocusState)
                    .frame(maxWidth: .infinity)

                Image("HappySmall")
            }

            Divider()

            TextEditor(text: $description)
                .overlay(alignment: .topLeading) {
                    if description.isEmpty {
                        Text("내용을 입력해주세요")
                            .foregroundColor(.gray500)
                            .onTapGesture {
                                descriptionFocusState = true
                            }
                            .padding(4)
                    }
                }
                .focused($descriptionFocusState)

            Capsule()
                .fill((!title.isEmpty && !description.isEmpty) ? Color.green500 : .gray400)
                .frame(height: 52)
                .overlay {
                    Text("작성완료")
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundColor(.white)
                }
                .padding(.bottom, 8)
                .buttonWrapper {
                    dismiss()
                }
        }
        .padding(.horizontal, 20)
        .onAppear {
            titleFocusState = true
        }
    }
}
