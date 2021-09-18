//
//  SallyCard.swift
//  SallyCard
//
//  Created by Eddie Gear on 10/09/2019.
//  Copyright © 2021 Weekend Launchpad. All rights reserved.
//


import CoreData
import SwiftUI

struct SallyCard: View {
    
    @State private var authorNote = ""
    @State private var authorName = ""
    @State private var authorHandle = ""
    
    @State private var image: Image? = Image("heart")
    @State private var shouldPresentImagePicker = false
    @State private var shouldPresentActionScheet = false
    @State private var shouldPresentCamera = false
    
    @State var twitterValue: Bool = false
    @State var linkedinValue : Bool = false
    @State var color = Color.white
    
    var sally: Sally
    
    var contentToSave: some View {
        
        VStack {
            VStack {
                HStack(alignment: .center) {
                    
                    if image != nil {
                        image?
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                            .shadow(radius: 10)
                            .overlay(Circle().stroke(Color.black, lineWidth: 1))
                            .aspectRatio(contentMode: .fit)
                        
                    } else {
                        // Backup if no image is selected
                        VStack{
                            Image(systemName: "person")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                                .shadow(radius: 10)
                        }
                    }
                    HStack {
                        VStack(alignment: .leading, spacing: 6) {
                            Text(sally.authorName ?? "" )
                                .font(.headline)
                            Text(sally.authorHandle ?? "" )
                                //.font(.caption)
                                .font(.system(size: 10))
                        }
                    }
                    
                    Spacer() // Add a spacer to push our HStack to the left and the spacer fill the empty space
                    
                    Image(systemName: "ellipsis")
                        .foregroundColor(.gray)
                }
                // .padding([.top, .leading, .trailing])
            }
            HStack {
                VStack(alignment: .leading) {
                    Text(sally.authorNote ?? "" )
                        .font(.callout)
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                        .padding(.bottom)
                        .frame(minHeight: 100)
                    
                    Text("7:15 PM * Aug 6, 2021 * Twitter for iPhone")
                        .font(.system(size: 8))
                        .multilineTextAlignment(.leading)
                    Divider()
                        .padding(.bottom)
                    HStack {
                        
                        Image(systemName: "bubble.left")
                            .foregroundColor(.gray)
                        Spacer()
                        Image(systemName: "repeat")
                            .foregroundColor(.gray)
                        Spacer()
                        Image(systemName: "heart")
                            .foregroundColor(.gray)
                        Spacer()
                        Image(systemName: "square.and.arrow.down")
                            .foregroundColor(.gray)
                    }
                    .padding(.bottom)
                    Divider()
                    Text(sally.hashtags ?? "")
                        .font(.caption)
                        .padding(.top)
                }
                
            }
        }
        //  .background(RoundedRectangle(cornerRadius: 10).fill(Color(.white).opacity(0.05)))
        .padding()
    }
    
    var body: some View {
        VStack {
            contentToSave
            
            Button(action: {
                contentToSave.saveAsImage(width: 500, height: 350) { image in
                    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                }
                print("Snapshot Generated.")
            })
            {
            }
        }
    }
    
    func shareID(Info: String) {
        let infoYou = Info
        let av = UIActivityViewController(activityItems: [infoYou], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
        if UIDevice.current.userInterfaceIdiom == .pad {
            av.popoverPresentationController?.sourceView = UIApplication.shared.windows.first
            av.popoverPresentationController?.sourceRect = CGRect(x: UIScreen.main.bounds.width / 2.1, y: UIScreen.main.bounds.height / 1.3, width: 200, height: 200)
        }
    }
    
}
extension View {
    func saveAsImage(width: CGFloat, height: CGFloat, _ completion: @escaping (UIImage) -> Void) {
        let size = CGSize(width: width, height: height)
        
        let controller = UIHostingController(rootView: self.frame(width: width, height: height))
        controller.view.bounds = CGRect(origin: .zero, size: size)
        let image = controller.view.asImage()
        
        completion(image)
    }
}

extension UIView {
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: self.bounds.size)
        return renderer.image { ctx in
            self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        }
    }
}




struct JokeCard_Previews: PreviewProvider {
    static var previews: some View {
        let sally = Sally(context: NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType))
        sally.authorNote = "What do you call a hen who counts her eggs?"
        sally.authorName = "A Mathemachichken"
        sally.authorHandle = "Silence"
        
        return SallyCard(sally: sally)
    }
}
