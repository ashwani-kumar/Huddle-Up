//
//  ContentView.swift
//  Huddlup
//
//  Created by Ashwani Kumar on 2020-08-09.
//  Copyright © 2020 Ashwani Kumar. All rights reserved.
//

import SwiftUI

struct DrawerContent: View {
    var body: some View {
        Color.blue
    }
}

struct NavigationDrawer: View {
    private let width = UIScreen.main.bounds.width - 100
    @Binding var isOpen: Bool
    
    var body: some View {
        HStack {
            DrawerContent()
                .frame(width: self.width)
                .offset(x: self.isOpen ? 0 : -self.width)
                .animation(.default)
            Spacer()
        }.onTapGesture {
            self.isOpen.toggle()
        }
    }
}

struct ContentView: View {
    @State var isDrawerOpen: Bool = false

    var body: some View {
        ZStack {
                /// Navigation Bar Title part
                if !self.isDrawerOpen {
                    NavigationView {
                        TabView {
                            Text("Page One")
                                .tabItem({
                                    Text("Page 1")
                                    Image(systemName: "1.circle")
                                })
                                .tag(1)
                            Text("Page Two")
                                .tabItem({
                                    Text("Page 2")
                                    Image(systemName: "2.circle")
                                })
                                .tag(2)
                            Text("Page Three")
                                .tabItem({
                                    Text("Page 3")
                                    Image(systemName: "3.circle")
                                })
                            .tag(3)
                        }.navigationBarTitle(Text("Navigation Drawer"))
                        .navigationBarItems(leading: Button(action: {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                        self.isDrawerOpen.toggle()
                                    }
                                }) {
                                    Image(systemName: "sidebar.left")
                                })
                    }
            }
                /// Navigation Drawer part
            NavigationDrawer(isOpen: self.$isDrawerOpen)
             /// Other behaviors
            }.background(Color.white)
            .onTapGesture {
                if self.isDrawerOpen {
                    self.isDrawerOpen.toggle()
                }
            }
        }
    }


struct RedView: View {
    var body: some View {
        Color.red
    }
}

struct BlueView: View {
    var body: some View {
        Color.blue
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
