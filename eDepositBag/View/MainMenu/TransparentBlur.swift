//
//  TransparentBlur.swift
//  eDepositBag
//
//  Created by Fall 2023 on 11/16/23.
//

import SwiftUI

struct TransparentBlur: UIViewRepresentable {
    var removeAllFilters: Bool

    func makeUIView(context: Context) -> TransparentBlurViewHelper {
        return TransparentBlurViewHelper(removeAllFilters: removeAllFilters)
    }

    func updateUIView(_ uiView: TransparentBlurViewHelper, context: Context) {
        // Implement any updates here
    }
}


class TransparentBlurViewHelper: UIVisualEffectView {
    init (removeAllFilters: Bool) {
        super.init(effect: UIBlurEffect(style: .systemUltraThinMaterial))
        if subviews.indices.contains (1) {
            subviews[1].alpha = 0
        }
        if let backdropLayer = layer.sublayers?.first {
            if removeAllFilters {
                backdropLayer.filters = []
            } else{
                backdropLayer.filters?.removeAll(where: { filter in
                    String(describing: filter) != "gaussianBlur"
                })
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func traitCollectionDidChange (_ previousTraitCollection: UITraitCollection?) {}
}
