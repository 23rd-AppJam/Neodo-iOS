import SwiftUI

struct Clothes: Hashable {
    let image: String
    let point: Int
}

struct MyNeodoView: View {
    @State var selectedState = "숲"
    @State var clothes: [Clothes] = [
        .init(image: "Tshirt", point: 50),
        .init(image: "Kara", point: 100),
        .init(image: "Melbbang", point: 200),
        .init(image: "Dress", point: 400)
    ]
    @State var selectedClothes: Clothes?
    @State var currentPoint = 1020
    @Namespace var segmentedAnimation

    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .black
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
    }

    var body: some View {
        NavigationStack {
            VStack {
                if selectedState == "숲" {
                    TabView {
                        LazyVGrid(columns: [.init(.flexible()), .init(.flexible())]) {
                            Image.sample1
                            Image.sample2
                            Image.sample3
                            Image.sample4
                        }
                        
                        LazyVGrid(columns: [.init(.flexible()), .init(.flexible())]) {
                            Image.sample1
                            Image.sample4
                            Image.sample2
                            Image.sample3
                        }
                        
                        LazyVGrid(columns: [.init(.flexible()), .init(.flexible())]) {
                            Image.sample4
                            Image.sample3
                            Image.sample2
                            Image.sample1
                        }
                    }
                    .tabViewStyle(.page)
                    .animation(nil, value: selectedState)
                    
                    segmented()
                        .matchedGeometryEffect(id: "SEGMENT", in: segmentedAnimation)
                        .padding(.bottom, 16)
                }

                if selectedState == "상점" {
                    if selectedClothes == nil {
                        Image("HappyChar3")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 133, height: 244)
                    } else {
                        Image("HappyMelChar3")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 133, height: 244)
                    }

                    ZStack {
                        Color.white
                            .transition(.move(edge: .bottom))
                            .animation(.default, value: selectedState)

                        VStack(alignment: .leading, spacing: 20) {
                            segmented()
                                .matchedGeometryEffect(id: "SEGMENT", in: segmentedAnimation)
                                .padding(.top, 16)

                            VStack(alignment: .leading, spacing: 16) {
                                Text("커스터마이징")
                                    .font(.system(size: 19, weight: .bold))

                                Text("의상")
                                    .foregroundColor(.green500)
                                    .font(.system(size: 16, weight: .bold))

                                ScrollView(.horizontal, showsIndicators: false) {
                                    LazyHStack {
                                        ForEach(clothes, id: \.self) { clothes in
                                            VStack(spacing: 5) {
                                                Image(clothes.image)
                                                    .frame(width: 120, height: 132)
                                                    .overlay {
                                                        if selectedClothes == clothes {
                                                            ZStack {
                                                                Color.black.opacity(0.3)

                                                                Image("check")
                                                            }
                                                        }
                                                    }
                                                
                                                if selectedClothes != clothes {
                                                    Text("\(clothes.point)P")
                                                        .foregroundColor(.gray500)
                                                        .font(.system(size: 15, weight: .semibold))
                                                } else {
                                                    Text("구매완료")
                                                        .foregroundColor(.gray500)
                                                        .font(.system(size: 15, weight: .semibold))
                                                }
                                            }
                                            .buttonWrapper {
                                                selectedClothes = clothes
                                                currentPoint -= 200
                                            }
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal, 20)

                            Spacer()
                        }
                    }
                    
                }
            }
            .background {
                Color.gray200
                    .ignoresSafeArea()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text(selectedState)
                        .font(.system(size: 22, weight: .bold))
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Text("\(currentPoint) P")
                        .font(.system(size: 16, weight: .semibold))
                }
            }
        }
    }

    @ViewBuilder
    func segmented() -> some View {
        HStack {
            Text("상점")
                .frame(maxWidth: .infinity)
                .foregroundColor(selectedState == "상점" ? .green500 : .gray900)
                .font(.system(size: 16, weight: .semibold))
                .buttonWrapper {
                    withAnimation {
                        selectedState = "상점"
                    }
                }

            Divider()
                .padding(.vertical, 7)

            Text("숲")
                .frame(maxWidth: .infinity)
                .foregroundColor(selectedState == "숲" ? .green500 : .gray900)
                .font(.system(size: 16, weight: .semibold))
                .buttonWrapper {
                    withAnimation {
                        selectedState = "숲"
                    }
                }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 52)
        .background {
            Color.white
                .clipShape(Capsule())
                .overlay {
                    Capsule()
                        .stroke(Color.gray300)
                }
        }
        .padding(.horizontal, 20)
    }
}
