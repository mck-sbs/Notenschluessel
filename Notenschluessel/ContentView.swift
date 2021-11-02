//
//  ContentView.swift
//  Notenschluessel
//
//  Created by Metin Karatas on 01.11.21.
//

import SwiftUI


let lst_IHK = [100.0, 91.0, 80.0, 66.0, 49.0, 29.0]
let lst_FS = [100.0, 85.0, 70.0, 55.0, 40.0, 20.0]


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
    @Published var maxp = "100" {
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
        
        if let m = Double(maxp){
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
            
        }
        
    }
    
    func mround(_ value: Double, step: Double) -> Double {
      return round(value / step) * step
    }
    
    
}


struct ContentView: View {
    
    @ObservedObject var tf = TF()
    @FocusState private var tfIsFocused: Bool
    
    private var gridItems = [
        GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible(), alignment: .leading), GridItem(.flexible())]
    

    var body: some View {
        
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
                TextField("max", text: $tf.maxp)
                    .keyboardType(.numberPad)
                    .focused($tfIsFocused)
                    .keyboardType(.numberPad)
                    .frame(width: 100).border(tf.isValid ? Color.green : Color.red)
                    .onChange(of: tf.maxp, perform: { (value) in
                        if let val = Int(value){
                            if (val >= 6)
                            {
                                tf.isValid = true
                                contenChange(val)
                            }
                            else{
                                tf.isValid = false
                            }

                        }
                        else{
                            tf.isValid = false
                        }
                        
                    })
                Button("OK") {
                    tfIsFocused = false
                    }
                .disabled(tf.isValid == false)
                

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
            
            }//vstack
        .frame(
          minWidth: 0,
          maxWidth: 800,
          minHeight: 0,
          maxHeight: 500,
          alignment: .topLeading
        )
        }//body
    }
    


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
