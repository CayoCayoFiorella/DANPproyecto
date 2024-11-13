//
//  ContentView.swift
//  Examen
//
//  Created by Aluyis on 10/7/24.
//

import SwiftUI

struct LoginView: View {
    @Binding var isLoggedIn: Bool
    @State private var username = ""
    @State private var password = ""
    @State private var loginFailed = false
    @State private var showPassword = false
    
    var body: some View {
        ZStack {
            Color(red: 0.47, green: 0.0, blue: 0.0078)
                .edgesIgnoringSafeArea(.all)

            VStack {
                Text("UNSA")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.bottom, 20)
                
                // Añade aquí tu imagen
                Image("Galerias_image")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 350, height: 350)
                    .padding(.bottom, 30)
                
                TextField("Username", text: $username)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal)
                
                ZStack {
                    if showPassword {
                        TextField("Password", text: $password)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            .padding(.horizontal)
                    } else {
                        SecureField("Password", text: $password)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            .padding(.horizontal)
                    }
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            showPassword.toggle()
                        }) {
                            Image(systemName: showPassword ? "eye.slash" : "eye")
                                .foregroundColor(.gray)
                        }
                        .padding(.trailing, 30)
                    }
                }
                .padding(.bottom, 20)
                
                Button(action: {
                    if username == "Admin" && password == "password" {
                        isLoggedIn = true
                    } else {
                        loginFailed = true
                    }
                }) {
                    Text("Login")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                
                if loginFailed {
                    Text("Login failed. Try again.")
                        .foregroundColor(.red)
                        .padding(.top, 10)
                }
            }
            .padding()
        }
    }
}


struct TabBarView: View {
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        TabView {
            NavigationView {
                HomeView(isLoggedIn: $isLoggedIn)
            }
            .tabItem {
                Label("Home", systemImage: "house")
            }
            
            GalleryView()
                .tabItem {
                    Image(systemName: "photo.fill.on.rectangle.fill")
                    Text("Galerías")
                }
            
            MapView()
                .tabItem {
                    Image(systemName: "map.fill")
                    Text("Mapa")
                }
            
            QRView()
                .tabItem {
                    Image(systemName: "qrcode") // Icono de QR
                    Text("QR")
                }
        }
    }
}

struct HomeView: View {
    @Binding var isLoggedIn: Bool
    
    var body: some View {
            VStack {
                Text("Nelson")
                    .font(.headline)
                    .padding(.bottom, 10) // Espaciado ajustado entre el nombre y el texto principal
                
                Text("Bienvenido a la Vista Principal (Home)")
                    .font(.body)
                    .padding(.bottom, 10) // Ajusta el espaciado aquí también
                    
                Spacer()
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline) // Esto hará que la barra de navegación sea compacta
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    // Botón de Logout en la esquina superior derecha
                    Button(action: {
                        isLoggedIn = false
                    }) {
                        Image(systemName: "power")
                            .foregroundColor(.red)
                    }
                }
            }
            .padding(.horizontal) // Ajuste de padding lateral
        }
}

struct GalleryView: View {
    @State private var searchText = ""
        
        // Datos simulados para la galería
        let artworks = [
            Artwork(imageName: "photo", title: "Sunset", author: "Author 1"),
            Artwork(imageName: "photo", title: "Mountain", author: "Author 2"),
            Artwork(imageName: "photo", title: "River", author: "Author 3"),
            Artwork(imageName: "photo", title: "Forest", author: "Author 4"),
            Artwork(imageName: "photo", title: "Cityscape", author: "Author 5")
        ]
        
        var filteredArtworks: [Artwork] {
            if searchText.isEmpty {
                return artworks
            } else {
                return artworks.filter { $0.title.localizedCaseInsensitiveContains(searchText) || $0.author.localizedCaseInsensitiveContains(searchText) }
            }
        }
        
        let columns = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
        
        var body: some View {
            NavigationView {
                VStack {
                    // Barra de búsqueda
                    TextField("Buscar por título o autor", text: $searchText)
                        .padding()
                        .background(Color(.systemGray5))
                        .cornerRadius(8)
                        .padding(.horizontal)
                    
                    // Lista en dos columnas
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(filteredArtworks) { artwork in
                                NavigationLink(destination: ArtworkDetailView(artwork: artwork)) {
                                    VStack {
                                        Image(systemName: artwork.imageName)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 100, height: 100)
                                            .padding()
                                        Text(artwork.title)
                                            .font(.headline)
                                        Text(artwork.author)
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                    .background(Color(.systemGray6))
                                    .cornerRadius(10)
                                    .padding(.horizontal)
                                }
                            }
                        }
                        .padding(.top)
                    }
                }
                .navigationTitle("Galerías")
            }
        }
}

struct ArtworkDetailView: View {
    let artwork: Artwork
    @State private var searchText = ""
    
    // Datos simulados de las pinturas
    let paintings = [
        Artwork(imageName: "photo", title: "Starry Night", author: "Vincent van Gogh"),
        Artwork(imageName: "photo", title: "The Persistence of Memory", author: "Salvador Dalí"),
        Artwork(imageName: "photo", title: "The Scream", author: "Edvard Munch"),
        Artwork(imageName: "photo", title: "Guernica", author: "Pablo Picasso"),
        Artwork(imageName: "photo", title: "Girl with a Pearl Earring", author: "Johannes Vermeer")
    ]
    
    var filteredPaintings: [Artwork] {
        if searchText.isEmpty {
            return paintings
        } else {
            return paintings.filter { $0.title.localizedCaseInsensitiveContains(searchText) || $0.author.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        VStack {
            // Barra de búsqueda
            TextField("Buscar por título o autor", text: $searchText)
                .padding()
                .background(Color(.systemGray5))
                .cornerRadius(8)
                .padding(.horizontal)
            
            // Lista vertical
            List(filteredPaintings) { painting in
                HStack {
                    Image(systemName: painting.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                    VStack(alignment: .leading) {
                        Text(painting.title)
                            .font(.headline)
                        Text(painting.author)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.vertical, 5)
            }
        }
        .navigationTitle(artwork.title)
    }
}

// Modelo para las obras de arte
struct Artwork: Identifiable {
    let id = UUID()
    let imageName: String
    let title: String
    let author: String
}

struct QRView: View {
    var body: some View {
        VStack {
            Text("Escanea el código QR")
                .font(.headline)
            Image(systemName: "qrcode") // Icono de QR para mostrar un ejemplo
                .resizable()
                .frame(width: 200, height: 200)
                .padding()
            // Aquí puedes agregar más contenido, como un botón para escanear QR
        }
        .navigationTitle("QR")
    }
}
