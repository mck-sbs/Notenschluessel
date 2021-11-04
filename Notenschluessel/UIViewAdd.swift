//
//  UIViewAdd.swift
//  Notenschluessel
//
//  Created by Metin Karatas on 04.11.21.
//

import SwiftUI


struct UIViewAdd: View {
    private var gridItems = [
        GridItem(.flexible(), spacing: 20), GridItem(.flexible())]
    
    @EnvironmentObject var tf : TF
    

    var body: some View {
        VStack{
            Text("NS-1 bis NS-5 können in % eingestellt werden")
            .fontWeight(.bold)
            .font(Font.subheadline)
            
            HStack(alignment: .center){
                Text("Notenschlüssel:")

                Picker(selection: $tf.selection, label: Text("Schlüssel")) {
                    ForEach(tf.noten_dict.keys.sorted(), id: \.self) { key in
                        Text(key).tag(key)
                    }}
                
            }
            VStack(alignment:.leading){

                LazyVGrid(columns: gridItems, spacing: 10) {
                    
                    Group {
                        Text("Note 6 bis einschließlich: ")
                        Picker(selection: $tf.lst[5], label: Text("Note 6")) {
                            ForEach(Array(stride(from: 1, to: 100, by: 0.5)), id: \.self){ i in
                                Text(String(format: "%.1f", i)).tag(i)
                                }
                            }
                        .disabled(!tf.editable)
                        
                        }
                    
                    Group {
                        Text("Note 5 bis einschließlich: ")
                        Picker(selection: $tf.lst[4], label: Text("Note 6")) {
                            ForEach(Array(stride(from: 1, to: 100, by: 0.5)), id: \.self){ i in
                                Text(String(format: "%.1f", i)).tag(i)
                                }
                            }
                        .disabled(!tf.editable)
                        }
                    
                    Group {
                        Text("Note 4 bis einschließlich: ")
                        Picker(selection: $tf.lst[3], label: Text("Note 6")) {
                            ForEach(Array(stride(from: 1, to: 100, by: 0.5)), id: \.self){ i in
                                Text(String(format: "%.1f", i)).tag(i)
                                }
                            }
                        .disabled(!tf.editable)
                        }
                    
                    Group {
                        Text("Note 3 bis einschließlich: ")
                        Picker(selection: $tf.lst[2], label: Text("Note 6")) {
                            ForEach(Array(stride(from: 1, to: 100, by: 0.5)), id: \.self){ i in
                                Text(String(format: "%.1f", i)).tag(i)
                                }
                            }
                        .disabled(!tf.editable)
                        }
                    
                    Group {
                        Text("Note 2 bis einschließlich: ")
                        Picker(selection: $tf.lst[1], label: Text("Note 6")) {
                            ForEach(Array(stride(from: 1, to: 100, by: 0.5)), id: \.self){ i in
                                Text(String(format: "%.1f", i)).tag(i)
                                }
                            }
                        .disabled(!tf.editable)
                        }
                    
                        
                    Group {
                        Text("Note 1 bis einschließlich: ")
                        Text("100")
                    }
                    
                }

                //Spacer()
            }//v1
            Text(" ")
            HStack
            {
                

                if(!tf.isValid)
                {
                    Image(systemName: "exclamationmark.triangle.fill" )
                }
                
                Button(action: {
                    
                    if((tf.selection != "IHK") && (tf.selection != "FS"))
                    {
                        tf.noten_dict[tf.selection] = tf.lst
                        tf.update()
                        
                        let defaults = UserDefaults.standard
                        defaults.set(tf.lst, forKey: tf.selection)
                        
                    }
                    
                }) {
                    Text("Speichern")
                }
                .disabled(!tf.editable || !tf.isValid)
            }//hstack

        }//v2
        .frame(
          minWidth: 0,
          maxWidth: 500,
          minHeight: 0,
          maxHeight: 500,
          alignment: .topLeading
        )
        
    }//body
}

struct UIViewAdd_Previews: PreviewProvider {
    static var previews: some View {
        UIViewAdd()
    }
}
