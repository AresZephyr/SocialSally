//
//  ContentView.swift
//  SocialSally
//
//  Created by Eddie Gear on 16/09/21.
//

import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    
    @FetchRequest(entity: Sally.entity(), sortDescriptors: []) var sallies: FetchedResults<Sally>
    @State var showingAddSally = false
    @Environment(\.managedObjectContext) var moc
    // @State private var image: Image?
    // @State private var inputImage: UIImage?
    @State private var showingFilterSheet = false
    @State private var showingImagePicker = false
    
    @State var twitterValue: Bool = false
    @State var linkedinValue : Bool = false
    @State var color = Color.white
    
    @State private var isShowPhotoLibrary = false
    @State private var image = UIImage()
    
    @State private var authorNote = "" // This is the post that the user writes
    @State private var authorName = "" // This is the name of the author
    @State private var authorHandle = "" // This is the username of the author
    @State private var authorImage: Image? = Image("Dad3")
    @State private var hashtags = ""
    
    var body: some View {
        
        NavigationView {
            VStack {
                SearchBar(text: $searchText)
                    .padding(3)
                
                Text("Your Words Can Change The World. Spread Them Wisely.")
                    .font(.system(size: 34))
                    .fontWeight(.bold)
                    .padding()
                    .foregroundColor(Color(red: 108 / 255, green: 155 / 255, blue: 246 / 255))
                    .multilineTextAlignment(.center)
                
                
                List{
                    ForEach(sallies, id: \.authorNote) { sally in
                        ForEach(sallies.filter { searchText.isEmpty ? true : $0.authorNote?.contains(searchText) as! Bool }) { sally in
                            SallyCard(sally: sally)
                            Text(sally.hashtags ?? "")
                            
                        }
                        .onDelete(perform: removeJokes)
                    }
                }
            }
            .navigationBarTitle("Social Posts")
            
            //            .navigationBarItems(leading: EditButton(), trailing: Button ("Add") {
            //                self.showingAddSally.toggle()
            //            })
            
            .navigationBarItems(leading: Button(action: {
                // do something
            }) {
                EditButton()
                    .foregroundColor(Color(red: 108 / 255, green: 155 / 255, blue: 246 / 255))

            }, trailing: Button(action: {
                                    self.showingAddSally.toggle()
                
            }) {
                Image(systemName: "plus.circle.fill")
                    .imageScale(.large)
                    .foregroundColor(Color(red: 108 / 255, green: 155 / 255, blue: 246 / 255))

                
            })
            
            
            
            
        }
        .sheet(isPresented: $showingAddSally) {
            AddView(isPresented: self.$showingAddSally).environment(\.managedObjectContext, self.moc)
        }
    }
    
    
    
    func removeJokes(at offsets: IndexSet) {
        for index in offsets {
            let sally = sallies[index]
            moc.delete(sally)
        }
        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
