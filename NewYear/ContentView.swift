
import SwiftUI

struct ContentView: View {
    
    let timer = Timer.publish(every: 3, on:  .main, in: .common).autoconnect()
    
    @State var start = false
    let fontsizes: [Font] = [.caption, .title, .largeTitle]
    let colors:[Color] = [.red, .yellow,.yellow,.yellow,.green,.red,.pink,.white,.red, .purple]
    @State var text = ""
    
    @State var angle:Double = 0
    @State var opasity = 0.0
    @State var scale = 1
    
    //random state var to update all on changing it
    @State var b = 0{
        willSet{
            angle = 180
            scale = 2
            text = ""
        }
        didSet{
            withAnimation(Animation.easeOut(duration: 3)){
                opasity = 1
                scale = 1
                angle = 0
            }
            
            withAnimation(Animation.easeOut(duration: 2)){
                text = "Happy New Year"
            }
        }
    }
    
    let w = UIScreen.main.bounds.width
    let h = UIScreen.main.bounds.height
    
    var body: some View {
        ZStack{
            Image("b0")
                .resizable()
                .scaledToFill()
            
            
            ForEach(0..<150){ n in
                Image(systemName: "staroflife")
                    
                    .foregroundColor(self.colors.randomElement()!)
                    .font(self.fontsizes.randomElement()!)
                    .scaleEffect(CGFloat.random(in: 0...2))
                    .opacity(self.opasity)
                    .position(x: CGFloat.random(in: 0...1000), y: CGFloat.random(in: 0...1000))
                    .animation(.easeOut(duration:3))
            }
            
            VStack{
                
                HStack{
                    ForEach(0..<text.count, id: \.self) { n in
                        
                        Text(String(Array(self.text)[n]))
                            .bold()
                            .font(.largeTitle)
                            .foregroundColor(self.colors.randomElement()!)
                            .opacity(self.opasity)
                            .animation(.default)
                    }
                    
                }.padding(.top,20)
                    .rotation3DEffect(.degrees(self.angle), axis: (x: 0, y: 1, z: 0))
                
                Spacer()
                
                Button("Click"){
                    if !self.start{
                        //on each onReceive from timer will change b to kick of animations.
                        self.start = true
                        self.b += 1
                    }
                    else{
                        self.timer.upstream.connect().cancel()
                    }
                }.padding(20)
                    .foregroundColor(Color.white)
                    .background(Color.red.opacity(0.6))
                    .clipShape(Circle())
            }
            
        }.onReceive(self.timer) {t in
            if self.start{
                self.b += 1
            }
        }
    }
}


