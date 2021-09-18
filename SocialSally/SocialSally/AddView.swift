//
//  AddView.swift
//  iCardSocial
//
//  Created by Eddie Gear on 10/09/2019.
//  Copyright © 2021 Weekend Launchpad. All rights reserved.
//



import SwiftUI
import UIKit
import CoreData
import Foundation


struct AddView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var showingAddSally
    @Binding var isPresented: Bool
    
    @State private var shouldPresentImagePicker = false
    @State private var shouldPresentActionScheet = false
    @State private var shouldPresentCamera = false
    
    @State private var isShowPhotoLibrary = false
    @State private var image = UIImage()
    
    @State private var authorNote = "" // This is the post that the user writes
    @State private var authorName = "" // This is the name of the author
    @State private var authorHandle = "" // This is the username of the author
    @State private var authorImage: Image? = Image("Dad3")
    @State private var hashtags = ""
    
    @State var twitterValue: Bool = false
    @State var linkedinValue : Bool = false
    @State var color = Color.white
    @State var timestamp = Date()
    
    
    var body: some View {
        
        NavigationView {
            Form {
                
                Section{
                    Text(timestamp.string(format: "EEEE, MMM d, yyyy"))
                    
                    VStack {
                        
                        Image(uiImage: self.image)
                            .resizable()
                            .scaledToFill()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .edgesIgnoringSafeArea(.all)
                            .onTapGesture {
                                self.isShowPhotoLibrary = true
                        }
                    }
                    .sheet(isPresented: $isShowPhotoLibrary) {
                        ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
                    }
                        
                    
                    TextField("Name...", text: $authorName)
                    TextField("@handle...", text: $authorHandle)
                    TextField("Write your message here...", text: $authorNote)
                        .multilineTextAlignment(.leading)
                        .lineLimit(10)
                    TextField("Hashtags...", text: $hashtags)
                }
                Toggle(isOn: $twitterValue){
                    Text("Twitter Badge")
                    if twitterValue {
                        Image("tBadge")
                            . resizable()
                            .frame(width: 20, height: 20)
                    }
                }
                Toggle(isOn: $linkedinValue){
                    Text("LinkedIn Badge")
                    if linkedinValue {
                        Image("lBadge")
                            . resizable()
                            .frame(width: 20, height: 20)
                    }
                }
                
                
                if #available(iOS 14.0, *) {
                    ColorPicker("Background color", selection: $color)
                } else {
                    // Fallback on earlier versions
                }
                
                HStack {
                    Spacer()
                    Button("Generate Card") {
                        
                        let newSally = Sally(context: self.moc)
                        
                        newSally.authorNote = self.authorNote
                        newSally.authorName = self.authorName
                        newSally.authorHandle = self.authorHandle
                        newSally.twitterValue = self.twitterValue
                        newSally.linkedinValue = self.linkedinValue
                        newSally.hashtags = self.hashtags
                     //   newSally.timestamp = self.timestamp
                        
                        do {
                            try self.moc.save()
                            self.showingAddSally.wrappedValue.dismiss()
                        } catch {
                            print("Whoops! \(error.localizedDescription)")
                        }
                    }
                }
                
            }
            .navigationBarTitle("New Sally")
        }
    }
}
extension Date {
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}


