//
//  FireworksParticle.swift
//  FireWorksEffect
//
//  Created by Angelos Staboulis on 23/11/25.
//

import Foundation
import SwiftUI
struct FireworkParticle: Identifiable {
    let id = UUID()
    var position: CGPoint
    var velocity: CGVector
    var color: Color
    var life: CGFloat = 1.0
}
