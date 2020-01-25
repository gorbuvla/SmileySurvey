//
//  PercentageItemView.swift
//  SmileySurvey
//
//  Created by Vlad Gorbunov on 25/01/2020.
//  Copyright © 2020 Vlad Gorbunov. All rights reserved.
//

import SwiftUI


enum RatingItem {
    case excellent(Int)
    case good(Int)
    case bad(Int)
    case disaster(Int)
}

struct RatingItemView: View {
    
    let ratingItem: RatingItem
    
    private var image: Image {
        get {
            switch ratingItem {
            case .excellent(_): return Image.ratingExcellent
            case .good(_): return Image.ratingGood
            case .bad(_): return Image.ratingBad
            case .disaster(_): return Image.ratingDisaster
            }
        }
    }
    
    private var percentage: Int {
        get {
            switch ratingItem {
            case .excellent(let value): return value
            case .good(let value): return value
            case .bad(let value): return value
            case .disaster(let value): return value
            }
        }
    }
    
    var body: some View {
        VStack {
            image.fitIntoBounds()
                .frame(width: 48.0, height: 48.0)
            
            Text(L10n.Survey.Detail.percentage(percentage))
                .font(.caption)
                .foregroundColor(.secondary)
            
        }
    }
}

struct RatingItemView_Previews: PreviewProvider {
    static var previews: some View {
        RatingItemView(ratingItem: .excellent(58))
    }
}
