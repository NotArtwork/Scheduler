//
//  Carousel.swift
//  Scheduler
//
//  Created by Alina Pisarenko on 1/8/25.
//

import SwiftUI


struct Parallelogram: Shape {
    var skewAmount: CGFloat = 0.3 // Controls the slant of the parallelogram

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let offset = rect.height * skewAmount

        path.move(to: CGPoint(x: 0, y: rect.height))
        path.addLine(to: CGPoint(x: rect.width - offset, y: rect.height))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        path.addLine(to: CGPoint(x: offset, y: 0))
        path.closeSubpath()

        return path
    }
}

struct ContinuousCarouselView: View {
    private let images = ["img1", "img1", "img1", "img1"] // Replace with your images
    private let imageWidth: CGFloat = 300 // Width of each image
    private let spacing: CGFloat = 20 // Spacing between images
    @State private var offset: CGFloat = 0 // Tracks the scroll position
    private let timer = Timer.publish(every: 0.03, on: .main, in: .common).autoconnect() // Timer for smooth scrolling

    var body: some View {
//        GeometryReader { geometry in
//            let totalWidth = CGFloat(images.count) * (imageWidth + spacing)
//            
//            HStack(spacing: spacing) {
//                ForEach(0..<images.count, id: \.self) { index in
//                    Image(images[index])
//                        .resizable()
//                        .scaledToFill()
//                        .frame(width: imageWidth, height: geometry.size.height * 0.8)
//                        .clipped()
//                }
//            }
//            .offset(x: offset)
//            .onReceive(timer) { _ in
//                withAnimation(.linear(duration: 0.03)) {
//                    offset -= 2 // Speed of scrolling
//                    if abs(offset) >= totalWidth - geometry.size.width {
//                        offset = 0 // Reset to create looping effect
//                    }
//                }
//            }
//        }
//        .frame(height: 200) // Adjust carousel height
//        .clipped() // Prevent content from overflowing
        
        Image("img1") // Replace with your image name
                    .resizable()
                    .scaledToFill()
                    .frame(width: 300, height: 200) // Set desired size
                    .clipShape(Parallelogram(skewAmount: 0.3)) // Apply parallelogram shape
                    .overlay(
                        Parallelogram(skewAmount: 0.3)
                            .stroke(Color.blue, lineWidth: 4) // Optional border
                    )
    }
    
}

struct ContinuousCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        ContinuousCarouselView()
    }
}
