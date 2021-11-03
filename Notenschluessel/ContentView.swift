//
//  ContentView.swift
//  Notenschluessel
//
//  Created by Metin Karatas on 01.11.21.
//

import SwiftUI


let lst_IHK = [100.0, 91.0, 80.0, 66.0, 49.0, 29.0]
let lst_FS = [100.0, 85.0, 70.0, 55.0, 40.0, 20.0]
let offset = 6

func contenChange(_ tag: Int) {
    print("content tag: \(tag)")
}

class TF: ObservableObject {
    var lst = lst_IHK
    
    @Published var isValid = true {
        didSet {

            }
    }
    // 1 -> IHK, 2 -> FS
    @Published var selection = 1 {
        didSet {
            self.update()
            }
    }
    @Published var maxp = 100  - 6{
        didSet {
            self.update()
            }
    }

    @Published var lst_von = ["90","81","65","48","19","0"] {
        didSet {

            }
        }
    @Published var lst_bis = ["100","91","80","66","49","29"] {
        didSet {

            }
        }
    
    func update(){
        print("update")
        
        //if let m = Double(maxp){
            let m = Double(maxp + offset)
            var tmp = 0.0
            
            if (self.selection == 1){
                self.lst = lst_IHK
            }
            else{
                self.lst = lst_FS
            }
            
            
            lst_bis[0] = String(m)
            
            tmp = (m * self.lst[1]) / 100
            lst_bis[1] = String(format: "%.1f", self.mround(tmp, step: 0.5))
            
            lst_von[0] = String(format: "%.1f", self.mround(tmp + 0.5, step: 0.5))

            tmp = (m * self.lst[2]) / 100
            lst_bis[2] = String(format: "%.1f", self.mround(tmp, step: 0.5))
            
            lst_von[1] = String(format: "%.1f", self.mround(tmp + 0.5, step: 0.5))
            
            tmp = (m * self.lst[3]) / 100
            lst_bis[3] = String(format: "%.1f", self.mround(tmp, step: 0.5))
            
            lst_von[2] = String(format: "%.1f", self.mround(tmp + 0.5, step: 0.5))
            
            tmp = (m * self.lst[4]) / 100
            lst_bis[4] = String(format: "%.1f", self.mround(tmp, step: 0.5))
            
            lst_von[3] = String(format: "%.1f", self.mround(tmp + 0.5, step: 0.5))
            
            tmp = (m * self.lst[5]) / 100
            lst_bis[5] = String(format: "%.1f", self.mround(tmp, step: 0.5))
            
            lst_von[4] = String(format: "%.1f", self.mround(tmp + 0.5, step: 0.5))
            
        //}
        
    }
    
    func mround(_ value: Double, step: Double) -> Double {
      return round(value / step) * step
    }
    
    
}


struct ContentView: View {
    
    @ObservedObject var tf = TF()
    @State var infoBtn = false
    
    private var gridItems = [
        GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible(), alignment: .leading), GridItem(.flexible())]
    

    var body: some View {
        
        NavigationView {
        VStack(){

            Text("Berechnung von Notenschlüsseln")
                .fontWeight(.bold)
                .font(.system(.largeTitle, design: .rounded))
                
            HStack(alignment: .center){
                Text(" Auswahl: ")
                    .font(.headline)
                    .multilineTextAlignment(.trailing)
                Picker(selection: $tf.selection, label: Text("Schlüssel")) {
                    Text("IHK").tag(1)
                    Text("FS").tag(2)
                }.onChange(of: tf.selection, perform: { (value) in
                    contenChange(value)
                })
            }//vstack
            
            //max. Punkte
            HStack(alignment: .center){
                //Spacer()
                Text("max. Punkte: ")
                    .font(.headline)
                    .multilineTextAlignment(.trailing)
                Picker("Number of people", selection: $tf.maxp) {
                    ForEach(6 ..< 201) {
                        Text("\($0)")
                        }

                    }

            }//hstack

            //Notenschlüssel
            LazyVGrid(columns: gridItems, spacing: 10) {
                ForEach((tf.lst_von.indices), id: \.self) {idx in
                    Text("Note ")
                        .font(.headline)
                    + Text(String(idx + 1))
                        .font(.headline)
                    Text("  ")
                    TextField("von", text: $tf.lst_bis[idx])
                        .disabled(true)
                    Text("bis")
                        .font(.headline)
                    TextField("von", text: $tf.lst_von[idx])
                        .disabled(true)
                
                    
                    }//foreach

                }//lazygrid
            /*Spacer()

            Image(systemName: "graduationcap")
                .font(.system(size: 70.0))*/
            //Spacer()

            
            }//vstack
            .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    infoBtn.toggle()
                },  label: {Image(systemName: "info.circle" )})
                }

            }
            .sheet(isPresented: $infoBtn, content: {
                VStack{
                    Text("Hinweise")
                    .fontWeight(.bold)
                    .font(.system(.largeTitle, design: .rounded))
                    Spacer()
                    Text("Es werden keinerlei Benutzerdaten gesammelt oder ausgewertet.\n\nDies ist eine Open-Source App. Wenn Sie weitere Notenschlüssel vorschlagen wollen, schreiben Sie eine Mail an notenschluessel@sbs-herzogenaurach.de\n\nInormationen zur App finden Sie auf der Homepage.\n\n")
                        .font(Font.subheadline)
                    Link("Link zur Homepage", destination: URL(string: "https://github.com/mck-sbs/Notenschluessel")!)
                        .foregroundColor(.blue)
                    Spacer()
                }

            })
            .frame(
              minWidth: 0,
              maxWidth: 500,
              minHeight: 0,
              maxHeight: 500,
              alignment: .topLeading
            )

        }//navigationview
        .navigationViewStyle(StackNavigationViewStyle())


        /*.sheet(isPresented: $infoBtn, content: {
            ZStack{
                Text("Hallo")
            }

        })*/

        }//body
    }
    


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 15.0, *) {
            ContentView()
                .previewInterfaceOrientation(.portrait)
        } else {
            // Fallback on earlier versions
        }
    }
}
