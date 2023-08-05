//
//  ContentView.swift
//  AppJam
//
//  Created by 최형우 on 2023/08/05.
//

import SwiftUI

struct CurrentTabKey: EnvironmentKey {
    static var defaultValue: Binding<Int> = .constant(1)
}

extension EnvironmentValues {
    var currentTab: Binding<Int> {
        get { self[CurrentTabKey.self] }
        set { self[CurrentTabKey.self] = newValue }
    }
}

struct ContentView: View {
    @State var selection = 1

    var body: some View {
        TabView(selection: $selection) {
            CalendarView()
                .tabItem {
                    selection == 0 ? Image.calendarFill : .calendar

                    Text("캘린더")
                        .foregroundColor(selection == 0 ? .green500 : .gray500)
                }
                .tag(0)
                .environment(\.currentTab, $selection)

            HomeView()
                .tabItem {
                    selection == 1 ? Image.homeFill : .home

                    Text("홈")
                        .foregroundColor(selection == 1 ? .green500 : .gray500)
                }
                .tag(1)
                .environment(\.currentTab, $selection)

            MyNeodoView()
                .tabItem {
                    selection == 2 ? Image.appjamFill : .appjam

                    Text("My 너도")
                        .foregroundColor(selection == 2 ? .green500 : .gray500)
                }
                .tag(2)
                .environment(\.currentTab, $selection)
        }
        .accentColor(.gray900)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
