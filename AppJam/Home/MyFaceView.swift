import SwiftUI

struct MyFaceView: View {
    @Environment(\.dismiss) var dismiss
    let rows = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        ScrollView {
            LazyVGrid(columns: rows) {
                Image.goodFace
                Image.grumpyFace
                Image.sadFace
                Image.happyFace
                    .buttonWrapper {
                        dismiss()
                    }
                Image.normalFace
            }
        }
    }
}
