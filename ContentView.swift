import SwiftUI

struct ContentView: View {
    let BUTTON_H: CGFloat = 50
    let BUTTON_W: CGFloat = 50
    @State var forest_emojis = ["☘️","🎋","🌲","🌵","🌳","🍁","🌴","🍄"]
    @State var animal_emojis = ["🐰","🦁","🐸","🐼","🪿","🦭","🐬","🐈"]
    @State var weather_emojis = ["☃️","🌞","🌈","☔️","🌊","☁️","🌪️","🌩️"]
    
    @State var cardCount = 16
    @State var selectedTheme: [String] = []
    
    
    var body: some View{
        VStack{
            Text("Memorize!").font(.largeTitle)
                .bold()
                .foregroundStyle(.pink)
                .padding(.bottom,10)
            ScrollView{
                cards
            }
            Spacer()
            themeButtons
        }.padding()
        
    }
    
    var cards: some View {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]){
                ForEach(0..<cardCount, id: \.self) { index in
                    CardView(content: selectedTheme.indices.contains(index) ? selectedTheme[index] : "")
                        .aspectRatio(2/3, contentMode: .fit)
                }
            }
            .foregroundColor(.pink)
        }
    var themeButtons: some View {
            HStack(spacing : 40) {
                Button(action: {
                    self.shuffleEmoji(for: forest_emojis)
                }) {
                    VStack {
                        Image(systemName: "tree.fill")
                            .resizable()
                            .foregroundColor(.pink)
                            .frame(width: BUTTON_W, height: BUTTON_H)
                        Text("Forest").foregroundStyle(.pink)
                    }
                }

                Button(action: {
                    self.shuffleEmoji(for: animal_emojis)
                }) {
                    VStack {
                        Image(systemName: "pawprint.fill")
                            .resizable()
                            .foregroundColor(.pink)
                            .frame(width: BUTTON_W, height: BUTTON_H)
                        Text("Animals").foregroundStyle(.pink)
                    }
                }

                Button(action: {
                    self.shuffleEmoji(for: weather_emojis)
                }) {
                    VStack {
                        Image(systemName: "sun.max.fill")
                            .resizable()
                            .foregroundColor(.pink)
                            .frame(width: BUTTON_W, height: BUTTON_H)
                        Text("Weather").foregroundStyle(.pink)
                    }
                }
            }
            .padding(.top, 10)
           
                }
    private func shuffleEmoji(for theme: [String]) {
            var shuffledTheme = theme.shuffled()
            while shuffledTheme.count < cardCount {
                shuffledTheme.append(contentsOf: theme.shuffled())
            }
            selectedTheme = Array(shuffledTheme.prefix(cardCount))
        }
    }

    struct CardView: View {
        let content: String
        @State var isFaceUp = false

        var body: some View {
            ZStack {
                let base = RoundedRectangle(cornerRadius: 12)
                if isFaceUp {
                    base.foregroundColor(.white)
                    base.strokeBorder(lineWidth: 2)
                    Text(content).font(.largeTitle)
                } else {
                    base
                }
            }
            .onTapGesture {
                isFaceUp.toggle()
            }
        }
    }

    #Preview {
    ContentView()
}
