//
//  MapView.swift
//  Examen
//
//  Created by Fiorella on 11/11/24.
//

import Foundation
import SwiftUI

struct MapView: View {
    var body: some View {
        ZStack {
            GalleryShape()
                .stroke(Color.black, lineWidth: 2)
                .background(Color.white)
                .frame(width: 400, height: 400)
            
            NavigationLink(destination: ArtworkDetailView(artwork: Artwork(imageName: "photo", title: "Sunset", author: "Author 1"))) {
                Text("GALERIA 1")
                    .foregroundColor(.blue)
                    .padding(5)
                    .background(Color.white)
                    .cornerRadius(8)
            }
            .position(x: 120, y: 500)
            
            Text("GALERIA 2").position(x: 70, y: 350)
            Text("GALERIA 3").position(x: 170, y: 290)
            Text("GALERIA 4").position(x: 70, y: 130)
            Text("SALA").position(x: 170, y: 90)
            Text("GALERIA 5").position(x: 330, y: 300)
            Text("GALERIA 6").position(x: 330, y: 425)
            Text("SSHH").position(x: 350, y: 90)
        }
        .padding()
        .navigationTitle("Mapa")
    
    }
}

struct GalleryShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Dibujar las galerías
        path.addRect(CGRect(x: 20, y: 350, width: 200, height: 100)) // Galeria 1
        path.addRect(CGRect(x: 20, y: 150, width: 100, height: 200)) // Galeria 2
        path.addRect(CGRect(x: 120, y: 150, width: 100, height: 80)) // Galeria 3
        path.addRect(CGRect(x: 20, y: -50, width: 100, height: 180))  // Galeria 4
        path.addRect(CGRect(x: 120, y: -50, width: 100, height: 80)) // Sala
        path.addRect(CGRect(x: 280, y: 150, width: 100, height: 100)) // Galeria 5
        path.addRect(CGRect(x: 280, y: 250, width: 100, height: 150)) // Galeria 6
        path.addRect(CGRect(x: 320, y: -50, width: 60, height: 80)) // Baño
        return path
    }
}

