//
//  Double+Extension.swift
//  ClassifyFruits
//
//  Created by Wongkraiwich Chuenchomphu on 10/2/24.
//

import Foundation

extension Double {
    func percentRoundedFormat(toPlaces places: Int) -> String {
        let divisor = pow(10.0, Double(places))
        let toPercentage = self * 100
        let rounded = (toPercentage * divisor).rounded() / divisor
        return String(format: "%.\(places)f", rounded)
    }
}
