//
//  ContentView.swift
//  testapp
//
//  Created by ANGUS HILTON on 10/09/2021.
//

import SwiftUI
struct Response:Codable{
    var results:[result]
}
struct result:Codable {
    var trackId:Int
    var trackName:String
    var collectionName:String
}

struct ContentView: View {
    @State var results = [result]()
    var body: some View {
        List(results, id: \.trackId){ result in
            VStack(alignment:.leading){
                Text(result.trackName)
                    .font(.headline)
               
                Text(result.collectionName)
            }
        }
        .onAppear(perform: loadData)
    }
    func loadData() {
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("url Invalid")
            return
        }
        
        let request = URLRequest(url:url)
        
        URLSession.shared.dataTask(with: request) { dta, response, error in
       
            if let data = dta{
                if let dataresponse = try? JSONDecoder().decode(Response.self, from: data){
                    
                    DispatchQueue.main.async {
                        self.results = dataresponse.results
                    }
                   return
                }
                    
            }
            print("failed to fetch data")
        }.resume()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(results: [result(trackId: 1, trackName: "h", collectionName: "n")])
    }
}
