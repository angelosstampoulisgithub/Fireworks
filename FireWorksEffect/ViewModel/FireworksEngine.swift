//
//  FireworksEngine.swift
//  FireWorksEffect
//
//  Created by Angelos Staboulis on 23/11/25.
//

import Foundation
import SwiftUI
class FireworksEngine: ObservableObject {
    @Published var particles: [FireworkParticle] = []
    var velocity: CGVector?
    var color:Color?
    var life:CGFloat?
    private var lastLaunchTime: Date = .now

    func update(timeDelta: CGFloat, size: CGSize) {
        // Launch new firework every 0.8 seconds
        if Date.now.timeIntervalSince(lastLaunchTime) > 0.8 {
            launchFirework(in: size)
            lastLaunchTime = .now
        }

        for i in particles.indices {
            particles[i].position.x += particles[i].velocity.dx * timeDelta
            particles[i].position.y += particles[i].velocity.dy * timeDelta
            particles[i].velocity.dy += 25 * timeDelta         // gravity
            particles[i].life -= 0.45 * timeDelta              // fade out
        }

        particles.removeAll { $0.life <= 0 }
    }

    private func launchFirework(in size: CGSize) {
        let origin = CGPoint(x: .random(in: 40...size.width-40),
                             y: size.height)
        velocity = .init(dx: .random(in: -5...5), dy: -250)
        color = Color.white.opacity(0.8)
        // Upward rocket
        let rocket = FireworkParticle(
            position: origin,
            velocity: velocity!,
            color: color!,
            life: 1.2
        )
        particles.append(rocket)

        // After 0.25s, explode
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            self.explode(at: CGPoint(x: origin.x, y: size.height - 600))
        }
    }

    private func explode(at point: CGPoint) {
        for _ in 0..<120 {
            let speed: CGFloat = .random(in: 40...200)
            let angle = CGFloat.random(in: 0...(.pi * 2))
            velocity = .init(dx: cos(angle) * speed, dy: sin(angle) * speed)
            life = .random(in: 0.8...1.4)
            particles.append(
                FireworkParticle(
                    position: point,
                    velocity: velocity!,
                    color: Color(hue: .random(in: 0...1), saturation: 1, brightness: 1),
                    life: life!
                )
            )
        }
    }
}
