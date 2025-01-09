//
//  Carousel.swift
//  Scheduler
//
//  Created by Alina Pisarenko on 1/8/25.
//

import SwiftUI


struct Parallelogram: Shape {
    var skewAmount: CGFloat = 0.3// Controls the slant of the parallelogram

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let offset = rect.height / 1.5 * skewAmount

        path.move(to: CGPoint(x: 0, y: rect.height))
        path.addLine(to: CGPoint(x: rect.width - offset, y: rect.height))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        path.addLine(to: CGPoint(x: offset, y: 0))
        path.closeSubpath()

        return path
    }
}

import SwiftUI

struct ContinuousCarouselView: View {
    private let images = ["img1", "img2", "img3", "img4", "img5"] // Replace with your image names
    private let imageWidth: CGFloat = 400 // Width of each image
    private let spacing: CGFloat = -50 // Spacing between images
    @State private var offset: CGFloat = 0 // Tracks the scroll position
    private let timer = Timer.publish(every: 0.03, on: .main, in: .common).autoconnect() // Timer for smooth scrolling

    var body: some View {
        GeometryReader { geometry in
            let totalImageWidth = imageWidth + spacing
            let totalContentWidth = CGFloat(images.count) * totalImageWidth

            HStack(spacing: spacing) {
                ForEach(0..<images.count * 3, id: \.self) { index in
                    let imageIndex = index % images.count
                    Image(images[imageIndex])
                        .resizable()
                        .scaledToFill()
                        .frame(width: 400, height: 500) // Set desired size
                        .clipShape(Parallelogram(skewAmount: 0.2)) // Apply parallelogram shape
                }
            }
            .offset(x: offset)
            .onReceive(timer) { _ in
                withAnimation(.linear(duration: 0.03)) {
                    offset -= 3 // Adjust speed by changing this value
                }
                // Seamless transition logic
                if abs(offset) >= totalContentWidth {
                    offset = 0 // Reset without visual jump
                }
            }
        }
        .frame(height: 500) // Adjust carousel height
        .clipped() // Prevent content from overflowing
    }
}

struct ContinuousCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        ContinuousCarouselView()
    }
}

// NICE BUT NOT SEAMLESS

//struct ContinuousCarouselView: View {
//    private let images = ["img1", "img1", "img1", "img1"] // Replace with your image names
//    private let imageWidth: CGFloat = 300 // Width of each image
//    private let spacing: CGFloat = -40 // Spacing between images
//    @State private var offset: CGFloat = 0 // Tracks the scroll position
//    private let timer = Timer.publish(every: 0.03, on: .main, in: .common).autoconnect() // Timer for smooth scrolling
//
//    var body: some View {
//        GeometryReader { geometry in
//            let totalImageWidth = imageWidth + spacing
//            let totalContentWidth = CGFloat(images.count) * totalImageWidth
//            let extendedImages = images + images // Duplicate the images to create a seamless effect
//            
//            HStack(spacing: spacing) {
//                ForEach(0..<extendedImages.count, id: \.self) { index in
//                    Image(extendedImages[index % images.count])
//                        .resizable()
//                        .scaledToFill()
//                        .frame(width: 350, height: 450) // Set desired size
//                        .clipShape(Parallelogram(skewAmount: 0.2)) // Apply parallelogram shape
////                        .overlay(
////                            Parallelogram(skewAmount: 0.2)
////                                .stroke(Color.blue, lineWidth: 4) // Optional border
////                        )
//
//                }
//            }
//            .offset(x: offset)
//            .onReceive(timer) { _ in
//                withAnimation(.linear(duration: 0.03)) {
//                    offset -= 3 // Adjust speed by changing the value
//                    
//                    if abs(offset) >= totalContentWidth {
//                        // Reset offset seamlessly without visual jump
//                        offset = 0
//                    }
//                }
//            }
//        }
//        .frame(height: 500) // Adjust carousel height
//        .clipped() // Prevent content overflow
//    }
//}
//
//struct ContinuousCarouselView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContinuousCarouselView()
//    }
//}


// SLIDE SHOW

//struct ImageCarouselView: View {
//    @State private var currentIndex = 1 // Start with the first image in the main array
//    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
//    private let images = ["img1", "img1", "img1"] // Replace with your image names
//
//    var body: some View {
//        let extendedImages = [images.last!] + images + [images.first!] // Duplicate edges for seamless looping
//
//        TabView(selection: $currentIndex) {
//            ForEach(0..<extendedImages.count, id: \.self) { index in
//                Image(extendedImages[index]) // Replace with your image name
//                            .resizable()
//                            .scaledToFill()
//                            .frame(width: 350, height: 500) // Set desired size
//                            .clipShape(Parallelogram(skewAmount: 0.2)) // Apply parallelogram shape
//                            .overlay(
//                                Parallelogram(skewAmount: 0.2)
//                                    .stroke(Color.blue, lineWidth: 4) // Optional border
//                            )
//            }
//        }
//        .tabViewStyle(PageTabViewStyle()) // Enables dots and swipe gestures
//        .frame(height: 500) // Adjust the carousel height
//        .onReceive(timer) { _ in
//            withAnimation {
//                currentIndex += 1
//                if currentIndex == extendedImages.count - 1 {
//                    // Reset to the first image after the last duplicate (seamless transition)
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
//                        currentIndex = 1
//                    }
//                }
//            }
//        }
//        .onChange(of: currentIndex) { newIndex in
//            // Handle manual swipe transitions
//            if newIndex == 0 {
//                currentIndex = extendedImages.count - 2 // Jump to the last real image
//            } else if newIndex == extendedImages.count - 1 {
//                currentIndex = 1 // Jump to the first real image
//            }
//        }
//    }
//}
//
//struct ImageCarouselView_Previews: PreviewProvider {
//    static var previews: some View {
//        ImageCarouselView()
//    }
//}


// IMAGE

//Image(images[index]) // Replace with your image name
//            .resizable()
//            .scaledToFill()
//            .frame(width: 350, height: 450) // Set desired size
//            .clipShape(Parallelogram(skewAmount: 0.2)) // Apply parallelogram shape
//            .overlay(
//                Parallelogram(skewAmount: 0.2)
//                    .stroke(Color.blue, lineWidth: 4) // Optional border
//            )
