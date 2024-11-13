//
//  ContentView.swift
//  Examen
//
//  Created by Aluyis on 10/7/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isLoggedIn = false
    @State private var isRegistering = false
    
    var body: some View {
        NavigationView {
            if isLoggedIn {
                // Mostrar la vista con la barra de navegación inferior (Home, Galerías, Mapa)
                TabBarView(isLoggedIn: $isLoggedIn)
            } else if isRegistering {
                RegisterView(isLoggedIn: $isLoggedIn)
            } else {
                // Mostrar la pantalla de Login si no está logueado
                LoginView(isLoggedIn: $isLoggedIn, isRegistering: $isRegistering)
            }
        }
    }
}

struct LoginView: View {
    @Binding var isLoggedIn: Bool
    @Binding var isRegistering: Bool
    @State private var username = ""
    @State private var password = ""
    @State private var loginFailed = false
    
    var body: some View {
        ZStack {
            // Fondo de color similar a #780002
            Color(red: 0.47, green: 0.0, blue: 0.0078)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer(minLength: 50) // Espacio adicional en la parte superior
                
                // Título "UNSA"
                Text("UNSA")
                    .font(.system(size: 34, weight: .bold)) // Usando font con tamaño y peso
                    .foregroundColor(.white)
                    .padding(.top, 20)

                // Imagen entre el título y el formulario
                Image("Galerias_image") // Reemplaza con el nombre de tu imagen en Assets
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 200)
                    .clipped()
                
                VStack(alignment: .leading, spacing: 8) {
                    // Subtítulo e indicaciones
                    Text("Inicio de Sesión")
                        .font(.system(size: 24, weight: .bold)) // Usando font con tamaño y peso
                        .foregroundColor(.white)
                    
                    Text("Inicia sesión con tu Usuario y Contraseña")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.7))
                    
                    // Campo de texto para el email
                    TextField("Email", text: $username)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .padding(.horizontal)
                    
                    // Campo de texto para la contraseña
                    SecureField("Contraseña", text: $password)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .padding(.horizontal)
                    
                    // Botón de inicio de sesión
                    Button(action: {
                        if username == "Admin" && password == "password" {
                            isLoggedIn = true
                        } else {
                            loginFailed = true
                        }
                    }) {
                        Text("Iniciar Sesión")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.black)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                    
                    // Mensaje de error
                    if loginFailed {
                        Text("Inicio de sesión fallido. Inténtalo de nuevo.")
                            .foregroundColor(.red)
                            .padding(.top, 10)
                    }
                    
                    // Texto de registro
                    HStack {
                        Spacer()
                        Text("¿No tienes cuenta?")
                            .foregroundColor(.white)
                        Button("Regístrate") {
                            isRegistering = true
                        }
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .bold)) // Aplicando tamaño y peso de fuente
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                }
                .padding()
                
                Spacer() // Esto asegura que el contenido no se quede pegado a la parte inferior
            }
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
