//
//  ContentView.swift
//  temtem-up
//
//  Created by Marlon Von Bernales Ansale on 17/03/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            TypeList()
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .tabItem {
                    Image(systemName: "bookmark.circle.fill")
                    Text("Type")
                }
                .tag(1)
            
                TemtemList()
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("TemTem")
                    }
                    .tag(0)
               
        
        }
    }
}

struct TemtemList: View {
    var body: some View {
        Text("Temtem Tab").font(.system(size: 30, weight: .bold, design: .rounded))
    }
}

struct TemtemType: Identifiable {
    let id: String
    let name: String
}

struct TypeList: View {
    
    let type: [TemtemType] = [
        TemtemType(id: "neutral", name: "Neutral"),
        TemtemType(id: "fire", name: "Fire"),
        TemtemType(id: "water", name: "Water"),
        TemtemType(id: "nature", name: "Nature"),
        TemtemType(id: "electric", name: "Electric"),
        TemtemType(id: "earth", name: "Earth"),
        TemtemType(id: "mental", name: "Mental"),
        TemtemType(id: "wind", name: "Wind"),
        TemtemType(id: "digital", name: "Digital"),
        TemtemType(id: "melee", name: "Melee"),
        TemtemType(id: "crystal", name: "Crystal"),
        TemtemType(id: "toxic", name: "Toxic")
    ]
    
    let columns = [
        GridItem(.fixed(80)),
        GridItem(.fixed(80)),
        GridItem(.fixed(80))
    ]
    
    private let timer = Timer.publish(every: 3.5, on: .main, in: .common).autoconnect()
        
    @State var animationTick = true
    @State var selectedType: TemtemType? = nil
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(type) { type in
                    TemtemTypeView(imageName: type.id).onTapGesture {
                        selectedType = type
                    }
                }
            } .padding(20)
              .background {
                    RoundedRectangle(cornerRadius: 10)
                        .trim(from: animationTick ? 0 : 1, to: 1) // we changed this a little bit
                        .stroke()
                        .foregroundColor(.yellow)
                        .padding(10)
                }.onReceive(timer) { _ in
                    withAnimation(.linear(duration: 3)) {
                        animationTick.toggle()
                    }
                }
            
            if let type = selectedType {
                TemtemSelectedTypeView(type: type)
            }
        }
        .background(content: {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color("background"))
        })
        .padding(10)
    }
}

struct TemtemSelectedTypeView: View {
    let type: TemtemType
    
    var body: some View {
        VStack {
            Image(type.id)
                .padding(10)
            Text(type.name)
                .foregroundColor(.yellow)
        }
        .padding(20)
        .background {
            RoundedRectangle(cornerRadius: 15.0, style: .continuous)
                .fill(.blue.gradient)
        }
        .animation(.easeInOut(duration: 0.5), value: type.id)
    }
}

struct TemtemTypeView: View {
    let imageName: String
    
    var body: some View {
        Image(imageName)
            .padding(10)
            .shimmer(withConfig: .init(tint: .yellow, highlight: .white.opacity(0.5), blur: 5))
            .background(content: {
                RoundedRectangle(cornerRadius: 15.0, style: .continuous)
                    .fill(.blue.gradient)
            })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
