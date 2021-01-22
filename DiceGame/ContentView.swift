//
//  ContentView.swift
//  DiceGame
//
//  Created by Dejan Hotic on 2021-01-22.
//

import SwiftUI

struct ContentView: View {
    // State gör att swiftUI tar över ansvaret att hålla reda på denna variabel. diceNumber. Då får vi ändra på den i vår struct
    
    @State var diceNumber1 = 1
    @State var diceNumber2 = 1
    @State var sum = 0
    @State var showingBustSheet = false
    
    var body: some View {
        ZStack {
            Color(red: 11.0/256, green: 96.0/256, blue: 60.0/256)
                .ignoresSafeArea()
            
            VStack {
                Text("\(sum)")
                    .font(.title)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                Spacer()
                HStack {
                    DiceView(n: diceNumber1)
                    DiceView(n: diceNumber2)
                }.onAppear() {
                    roll()
                }
                Spacer()
                Button(action: {
                    // Roll the dice
                    print("Roll dice")
                    roll()
                }) {
                    Text("Roll Dice")
                        .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color.white)
                        .padding(.horizontal)
                }
                .background(Color.red)
                .cornerRadius(12.0)
                Spacer()
            }
        }
        .sheet(isPresented: $showingBustSheet, onDismiss: {sum = 0 }) {
            BustSheet(sum: sum)
        }
    }
    func roll() {
        diceNumber1 = Int.random(in: 1...6)
        diceNumber2 = Int.random(in: 1...6)
        sum += diceNumber1 + diceNumber2
        if(sum > 21) {
            showingBustSheet = true
        }
        //Fungerar på samma sätt som if satsen.
        //showingBustSheet = sum > 21
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        //BustSheet()
    }
}

struct BustSheet : View{
    let sum: Int
    var body : some View {
        ZStack {
            Color(red: 11.0/256, green: 96.0/256, blue: 60.0/256)
                .ignoresSafeArea()
            VStack {
                Text("Bust")
                    .foregroundColor(.white)
                    .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                    .padding()
                Text("\(sum)")
                    .font(.largeTitle)
                    .foregroundColor(.red)
                    .padding()
            }
        }
    }
}

struct DiceView: View {
    let n: Int

    var body: some View {
        Image(systemName: "die.face.\(n)" )
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding()
    }
}
