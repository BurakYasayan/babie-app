//
//  LoginView.swift
//  babie
//
//  Created by Oğuzhan Aydın on 15.05.2026.
//
import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isPasswordVisible: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(hex: "F9FAFC").ignoresSafeArea()
                
                VStack(spacing: 30) {
                    
                    // 1. Logo ve Karşılama
                    VStack(spacing: 16) {
                        Circle()
                            .fill(Color(hex: "FFD8CE"))
                            .frame(width: 90, height: 90)
                            .overlay(
                                Text("b+")
                                    .font(.system(size: 36, weight: .bold))
                                    .foregroundColor(Color(hex: "A36653"))
                            )
                            .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
                        
                        Text("Tekrar Hoş Geldiniz")
                            .font(.system(size: 26, weight: .bold))
                            .foregroundColor(Color(hex: "345C72"))
                        
                        Text("Bebeğinizin aboneliğini yönetmek için giriş yapın.")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)
                    }
                    .padding(.top, 40)
                    
                    // 2. Giriş Formu
                    VStack(spacing: 16) {
                        CustomTextField(icon: "envelope.fill", placeholder: "E-posta Adresiniz", text: $email, keyboardType: .emailAddress)
                        
                        // Şifre Alanı
                        HStack {
                            Image(systemName: "lock.fill")
                                .foregroundColor(.gray)
                                .frame(width: 24)
                            
                            if isPasswordVisible {
                                TextField("Şifreniz", text: $password)
                                    .font(.system(size: 15, weight: .medium))
                                    .autocapitalization(.none)
                            } else {
                                SecureField("Şifreniz", text: $password)
                                    .font(.system(size: 15, weight: .medium))
                                    .autocapitalization(.none)
                            }
                            
                            Button(action: { isPasswordVisible.toggle() }) {
                                Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(color: .black.opacity(0.02), radius: 5, x: 0, y: 2)
                        
                        // Şifremi Unuttum
                        HStack {
                            Spacer()
                            Button(action: {
                                // Şifre sıfırlama işlemi
                            }) {
                                Text("Şifremi Unuttum")
                                    .font(.system(size: 13, weight: .bold))
                                    .foregroundColor(Color(hex: "A36653"))
                            }
                        }
                    }
                    .padding(.horizontal, 24)
                    
                    // 3. Giriş Butonu
                    Button(action: {
                        // TODO: Supabase Giriş İşlemi
                        print("Giriş yapılıyor: \(email)")
                    }) {
                        Text("Giriş Yap")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color(hex: "345C72"))
                            .cornerRadius(12)
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 10)
                    
                    Spacer()
                    
                    // 4. Kayıt Ol Yönlendirmesi
                    HStack(spacing: 4) {
                        Text("Hesabınız yok mu?")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                        
                        // Önceki adımda yaptığımız SignUpView sayfasına bağladık
                        NavigationLink(destination: SignUpView()) {
                            Text("Kayıt Ol")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(Color(hex: "345C72"))
                        }
                    }
                    .padding(.bottom, 30)
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
