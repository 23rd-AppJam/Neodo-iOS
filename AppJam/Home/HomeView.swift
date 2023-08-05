import SwiftUI

struct Todo: Hashable, Identifiable {
    let id = UUID().uuidString
    var todo: String
    var point: Int
    var isChecked: Bool
}

struct HomeView: View {
    @Environment(\.currentTab) var currentTab
    @State var charString = "Char2"
    @State var currentWeeks = [Date]()
    @State var todo: [Todo] = [
        .init(todo: "식물에 물주기", point: 10, isChecked: false),
        .init(todo: "걷기", point: 10, isChecked: false),
        .init(todo: "나에게 물주기", point: 10, isChecked: false)
    ]
    @State var selectedTodo: Todo? {
        didSet {
            if selectedTodo == nil {
                UITabBar.showTabBar()
            } else {
                UITabBar.hideTabBar()
            }
        }
    }
    @State var isPresentedFace = false
    @State var currentPoint = 1000

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 25) {
                    Image(self.charString)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 133, height: 244)
                        .background(alignment: .bottom) {
                            Image.ellps
                                .offset(y: 8)
                        }
                        .buttonWrapper {
                            isPresentedFace = true
                        }
                        .animation(.default, value: self.charString)

                    VStack(spacing: 12) {
                        Color.white
                            .cornerRadius(8)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .padding(.horizontal, 20)
                            .overlay(alignment: .leading) {
                                Text("오늘도 잘하고 있어요!")
                                    .font(.system(size: 16, weight: .semibold))
                                    .padding(.horizontal, 40)
                            }
                            .padding(.top, 16)

                        todoList()

                        HStack(spacing: 12) {
                            Image("Shop")

                            Text("상점으로 가기")
                                .font(.system(size: 16, weight: .semibold))

                            Spacer()

                            Image.arrowForward
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 15)
                        .background {
                            Color.white
                                .cornerRadius(8)
                        }
                        .padding(.horizontal, 20)
                        .buttonWrapper {
                            currentTab.wrappedValue = 2
                        }
                    }

                    Spacer()
                }
            }
            .onAppear {
                currentWeeks = Date().fetchAllDatesInCurrentWeek()
            }
            .background {
                Color.gray200
                    .ignoresSafeArea()
            }
            .overlay {
                Group {
                    if let selectedTodo {
                        ZStack(alignment: .bottom) {
                            Color.black.opacity(0.35)

                            bottomSheet(todo: selectedTodo)
                        }
                        .ignoresSafeArea()
                    }
                }
                .animation(.default, value: selectedTodo)
            }
            .overlay {
                Group {
                    if isPresentedFace {
                        ZStack {
                            Color.black.opacity(0.35)
                                .onTapGesture {
                                    isPresentedFace = false
                                }

                            VStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.white)
                                    .padding(.horizontal, 20)
                                    .frame(height: 80)
                                    .offset(y: -225)
                                    .overlay {
                                        HStack(spacing: 14) {
                                            Image.goodFace
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                            Image.grumpyFace
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                            Image.sadFace
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                            Image.happyFace
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                                .buttonWrapper {
                                                    self.isPresentedFace = false
                                                    self.charString = "HappyChar2"
                                                }
                                            Image.normalFace
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                        }
                                        .offset(y: -225)
                                    }
                            }
                        }
                        .ignoresSafeArea()
                    }
                }
                .animation(.default, value: isPresentedFace)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("너도")
                        .font(.system(size: 22, weight: .bold))
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Text("\(currentPoint) P")
                        .font(.system(size: 16, weight: .semibold))
                }
            }
            .onDisappear {
                charString = "HappyMelChar3"
                currentPoint -= 200
            }
        }
    }

    @ViewBuilder
    func todoList() -> some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Text("오늘 할 일")
                    .font(.system(size: 16, weight: .bold))

                Spacer()

                Image.plus
                    .padding(.trailing, 4)
            }

            ForEach($todo, id: \.self) { $todo in
                todoRow(todo: $todo)
            }
        }
        .animation(.default, value: todo)
        .padding(20)
        .frame(maxWidth: .infinity)
        .background {
            Color.white
                .cornerRadius(8)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 15)
    }

    @ViewBuilder
    func todoRow(todo: Binding<Todo>) -> some View {
        HStack(spacing: 5) {
            Group {
                if todo.wrappedValue.isChecked {
                    Image.checkCircleFill
                } else {
                    Image.checkCircle
                }
            }
            .buttonWrapper {
                self.charString = "HappyChar3"
                todo.wrappedValue.isChecked.toggle()
                currentPoint += todo.wrappedValue.point
            }

            HStack(spacing: 8) {
                Text(todo.todo.wrappedValue)
                    .font(.system(size: 16, weight: .medium))

                Text("\(todo.wrappedValue.point)P")
                    .font(.system(size: 13, weight: .medium))
            }

            Spacer()

            Image.moreVert
                .buttonWrapper {
                    self.selectedTodo = todo.wrappedValue
                }
        }
    }

    @ViewBuilder
    func bottomSheet(todo: Todo) -> some View {
        Color.white
            .cornerRadius(20, corners: [.topLeft, .topRight])
            .ignoresSafeArea()
            .overlay {
                VStack(spacing: 10) {
                    Color.gray500
                        .frame(width: 55, height: 1)
                        .clipShape(Capsule())

                    Text(todo.todo)
                        .font(.system(size: 16, weight: .semibold))

                    HStack(spacing: 15) {
                        VStack(spacing: 5) {
                            Image.pencil

                            Text("수정하기")
                                .foregroundColor(.black)
                                .font(.system(size: 16, weight: .semibold))
                        }
                        .padding(10)
                        .frame(maxWidth: .infinity)
                        .background {
                            Color.green50
                                .cornerRadius(8)
                        }
                        .buttonWrapper {
                            self.selectedTodo = nil
                        }

                        VStack(spacing: 5) {
                            Image.trash

                            Text("삭제하기")
                                .foregroundColor(.black)
                                .font(.system(size: 16, weight: .semibold))
                        }
                        .padding(10)
                        .frame(maxWidth: .infinity)
                        .background {
                            Color.red50
                                .cornerRadius(8)
                        }
                        .buttonWrapper {
                            self.todo.removeAll { $0 == todo }
                            self.selectedTodo = nil
                        }
                    }
                    .padding(.horizontal, 20)
                }
            }
            .frame(height: 170)
    }
}

struct BackgroundBlurView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}
