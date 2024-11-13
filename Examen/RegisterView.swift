//
//  RegisterView.swift
//  Examen
//
//  Created by Fiorella on 13/11/24.
//

import Foundation

import SwiftUI

struct RegisterView: View {
    @Binding var isLoggedIn: Bool
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var registrationFailed = false
    
    var body: some View {
        ZStack {
            // Fondo de color similar a #780002
            Color(red: 0.47, green: 0.0, blue: 0.0078)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer(minLength: 50) // Espacio adicional en la parte superior
                
                // Título "UNSA"
                Text("Registro")
                    .font(.system(size: 34, weight: .bold)) // Usando font con tamaño y peso
                    .foregroundColor(.white)
                    .padding(.top, 20)
                
                // Subtítulo
                Text("Llene los siguientes datos para su registro")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.7))
                    .padding(.top, 10)
                
                VStack(alignment: .leading, spacing: 8) {
                    // Campo de texto para los nombres
                    TextField("Nombres", text: $firstName)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .padding(.horizontal)
                    
                    // Campo de texto para los apellidos
                    TextField("Apellidos", text: $lastName)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .padding(.horizontal)
                    
                    // Campo de texto para el email
                    TextField("Email", text: $email)
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
                    
                    // Campo de texto para confirmar la contraseña
                    SecureField("Confirmar Contraseña", text: $confirmPassword)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .padding(.horizontal)
                    
                    // Botón de registro
                    Button(action: {
                        // Lógica para registrar al usuario
                        if password == confirmPassword {
                            // Aquí puedes agregar la lógica para guardar el registro
                            isLoggedIn = true
                        } else {
                            registrationFailed = true
                        }
                    }) {
                        Text("Registrar")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.black)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                    
                    // Mensaje de error
                    if registrationFailed {
                        Text("Las contraseñas no coinciden. Inténtalo de nuevo.")
                            .foregroundColor(.red)
                            .padding(.top, 10)
                    }
                    
                    // Texto de inicio de sesión
                    HStack {
                        Spacer()
                        Text("¿Ya tienes una cuenta?")
                            .foregroundColor(.white)
                        Button("Iniciar sesión") {
                            // Acción para ir al Login
                            isLoggedIn = false
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
