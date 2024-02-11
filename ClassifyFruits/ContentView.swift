//
//  ContentView.swift
//  ClassifyFruits
//
//  Created by Wongkraiwich Chuenchomphu on 10/2/24.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    
    @StateObject private var classifier = ImageClassifier()
    
    var body: some View {
        VStack {
            HStack {
                Text("Fruits Classifier")
                    .font(.title.bold())
                Spacer()
                Text("🍎🍌🍇🥭🍓")
            }
            Spacer()
            
            if let first = classifier.results.first {
                Text("\(first.fruitName): \(first.percent)% sure")
                    .padding(.horizontal)
                    .font(.title2.bold())
            }
            
            if let image = classifier.uiImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding()
            }
            
            if classifier.uiImage != nil {
                Button(action: classifier.classify) {
                    Text("Predict")
                }.buttonStyle(.borderedProminent)
            }
            
            Spacer()
            
            PhotosPicker(
                selection: $classifier.photoPickerItem,
                matching: .images
            ) {
                Image(systemName: "photo.on.rectangle.angled")
                Text("Select Photo")
            }
        }
        .padding()
        .onChange(of: classifier.photoPickerItem, { newValue, _ in
            Task {
                do {
                    let data = try await classifier.photoPickerItem?.loadTransferable(type: Data.self)
                    
                    guard let unwrappedData = data else {
                        print("Error")
                        return
                    }
                    
                    classifier.uiImage = UIImage(data: unwrappedData)
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        })
    }
}

#Preview {
    ContentView()
}
