import SwiftUI

struct SignUpView: View {
    // Kullanıcı adı değişkeni eklendi
    @State private var username: String = ""
    @State private var motherName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var babyName: String = ""
    @State private var babyBirthDate: Date = Date()
    @State private var isPasswordVisible: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(hex: "F9FAFC").ignoresSafeArea()
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 30) {
                        
                        // 1. Üst Başlık ve Karşılama Alanı
                        VStack(spacing: 8) {
                            Text("babie+'a Hoş Geldiniz")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(Color(hex: "345C72"))
                            Text("Sizin ve bebeğinizin yolculuğunu kolaylaştırmak için buradayız.")
                                .font(.system(size: 15)).foregroundColor(.gray).multilineTextAlignment(.center).padding(.horizontal, 20)
                        }
                        .padding(.top, 20)
                        
                        // 2. Hesap ve Anne Bilgileri Formu
                        VStack(alignment: .leading, spacing: 18) {
                            Text("Hesap ve Anne Bilgileri")
                                .font(.system(size: 14, weight: .bold)).foregroundColor(Color(hex: "A36653")).padding(.leading, 5)
                            
                            CustomTextField(icon: "at", placeholder: "Kullanıcı Adınız (örn: mira_annee)", text: $username)
                                .textInputAutocapitalization(.never) // Kullanıcı adları genelde küçük harf başlar
                            
                            CustomTextField(icon: "person.fill", placeholder: "Adınız ve Soyadınız", text: $motherName)
                            CustomTextField(icon: "envelope.fill", placeholder: "E-posta Adresiniz", text: $email, keyboardType: .emailAddress)
                            
                            HStack {
                                Image(systemName: "lock.fill").foregroundColor(.gray).frame(width: 24)
                                if isPasswordVisible {
                                    TextField("Şifre Belirleyin", text: $password).font(.system(size: 15, weight: .medium)).autocapitalization(.none)
                                } else {
                                    SecureField("Şifre Belirleyin", text: $password).font(.system(size: 15, weight: .medium)).autocapitalization(.none)
                                }
                                Button(action: { isPasswordVisible.toggle() }) {
                                    Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill").foregroundColor(.gray)
                                }
                            }
                            .padding().background(Color.white).cornerRadius(12).shadow(color: .black.opacity(0.02), radius: 5, x: 0, y: 2)
                        }
                        .padding(.horizontal, 24)
                        
                        // 3. Bebek Bilgileri Formu
                        VStack(alignment: .leading, spacing: 18) {
                            Text("Bebek Bilgileri")
                                .font(.system(size: 14, weight: .bold)).foregroundColor(Color(hex: "A36653")).padding(.leading, 5)
                            
                            CustomTextField(icon: "face.smiling", placeholder: "Bebeğinizin Adı", text: $babyName)
                            
                            HStack {
                                Image(systemName: "calendar").foregroundColor(.gray).frame(width: 24)
                                DatePicker("Doğum Tarihi", selection: $babyBirthDate, displayedComponents: .date)
                                    .font(.system(size: 14, weight: .medium)).foregroundColor(.gray)
                            }
                            .padding().background(Color.white).cornerRadius(12).shadow(color: .black.opacity(0.02), radius: 5, x: 0, y: 2)
                        }
                        .padding(.horizontal, 24)
                        
                        // 4. Kayıt Ol Butonu
                        Button(action: {
                            print("Kayıt: \(username), \(motherName), \(babyName)")
                        }) {
                            Text("Hesap Oluştur")
                                .font(.system(size: 16, weight: .bold)).foregroundColor(.white).frame(maxWidth: .infinity).padding(.vertical, 16)
                                .background(Color(hex: "345C72")).cornerRadius(12)
                        }
                        .padding(.horizontal, 24)
                        
                        // 5. Giriş Yap Yönlendirmesi
                        HStack(spacing: 4) {
                            Text("Zaten bir hesabınız var mı?").font(.system(size: 14)).foregroundColor(.gray)
                            Button(action: {}) { Text("Giriş Yap").font(.system(size: 14, weight: .bold)).foregroundColor(Color(hex: "345C72")) }
                        }
                        .padding(.bottom, 30)
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}

// MARK: - İŞTE EKSİK OLAN YARDIMCI BİLEŞEN
struct CustomTextField: View {
    var icon: String
    var placeholder: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.gray)
                .frame(width: 24)
            
            TextField(placeholder, text: $text)
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(Color(hex: "333333"))
                .keyboardType(keyboardType)
                .autocapitalization(.none)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.02), radius: 5, x: 0, y: 2)
    }
}

// Preview
struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
