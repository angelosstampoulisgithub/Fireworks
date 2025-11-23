//
//  FireworksView.swift
//  FireWorksEffect
//
//  Created by Angelos Staboulis on 23/11/25.
//

import SwiftUI
import Foundation

struct FireworksView: View {
    @StateObject private var engine = FireworksEngine()

    var body: some View {
        TimelineView(.animation) { timeline in
            Canvas { context, size in
                let dt = CGFloat(timeline.date.timeIntervalSince1970)

                for p in engine.particles {
                    let circle = Path(ellipseIn: CGRect(
                        x: p.position.x,
                        y: p.position.y,
                        width: 6,
                        height: 6)
                    )

                    context.opacity = p.life
                    context.fill(circle, with: .color(p.color))
                }
            }
            .background(Color.black)
            .onChange(of: timeline.date) { newTime in
                engine.update(timeDelta: 0.016, size: UIScreen.main.bounds.size)
            }
        }
        .ignoresSafeArea()
    }
}
