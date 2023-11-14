//
//  ContentView.swift
//  AsyncStreamSample
//
//  Created by 江本 光晴 on 2023/11/07.
//

import SwiftUI

struct ContentView: View {
    
    let monitor = Monitor()
    let monitor2 = Monitor2()
    
    var body: some View {
        VStack {
            Button {
                print("aaa")
  
                monitor.put("monitor1")
                monitor2.put("monitor2")
                
            } label: {
                Text("Hello, world!")
            }
        }
        .padding()
        .onAppear{
            monitor.start()
            monitor2.start()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
