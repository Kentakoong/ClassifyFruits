//
//  ImageClassifier.swift
//  ClassifyFruits
//
//  Created by Wongkraiwich Chuenchomphu on 10/2/24.
//

import Foundation
import SwiftUI
import PhotosUI
import Vision

struct Prediction {
    var fruitName: String
    var percent: String
}

class ImageClassifier: ObservableObject {
    @Published var photoPickerItem : PhotosPickerItem? = nil
    
    @Published var uiImage : UIImage?
    
    @Published var results: [Prediction] = []
    
    func classify() {
        guard let cvPixelBuffer = uiImage?.convertToBuffer() else { return }
        
        do {
            let model = try FruitsClassifier(configuration: MLModelConfiguration())
            
            let prediction = try model.prediction(image: cvPixelBuffer)
            
            self.results = prediction.targetProbability.map{ key, value in
                return Prediction(fruitName: key, percent: value.percentRoundedFormat(toPlaces: 2))
            }.sorted(by: { $0.percent > $1.percent })
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
