import SwiftUI

struct BabyProfileView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color(hex: "F9FAFC").ignoresSafeArea()
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 24) {
                        ProfileHeaderSection()
                        ProfileStatsSection()
                        BadgesSection()
                        BabyDevelopmentSection()
                        ActionButtonsSection()
                    }
                    .padding(.vertical, 20)
                    .padding(.bottom, 40) // Tab bar'ın altında kalmaması için
                }
            }
            .navigationTitle("babie+ Profilim")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// MARK: - Alt Bileşenler (Subviews)

struct ProfileHeaderSection: View {
    var body: some View {
        VStack(spacing: 12) {
            ZStack(alignment: .bottomTrailing) {
                Circle()
                    .fill(Color(hex: "FFD8CE"))
                    .frame(width: 110, height: 110)
                    .overlay(Text("AY").font(.system(size: 40, weight: .bold)).foregroundColor(Color(hex: "A36653")))
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
                
                Circle()
                    .fill(Color(hex: "345C72"))
                    .frame(width: 32, height: 32)
                    .overlay(Image(systemName: "star.fill").font(.system(size: 14)).foregroundColor(.white))
                    .overlay(Circle().stroke(Color.white, lineWidth: 3))
                    .offset(x: -5, y: -5)
            }
            VStack(spacing: 4) {
                Text("Ayşe Yılmaz").font(.system(size: 22, weight: .bold)).foregroundColor(Color(hex: "333333"))
                Text("@ayse_ve_mira • Plus Üye").font(.system(size: 14, weight: .medium)).foregroundColor(.gray)
            }
        }
    }
}

struct ProfileStatsSection: View {
    var body: some View {
        HStack(spacing: 0) {
            // StatItem ismi SubscriptionView ile çakışmasın diye ProfileStatItem olarak değiştirildi
            ProfileStatItem(value: "7 Ay", title: "Abonelik")
            Divider().frame(height: 40).background(Color.gray.opacity(0.3))
            ProfileStatItem(value: "1.2K", title: "Takipçi")
            Divider().frame(height: 40).background(Color.gray.opacity(0.3))
            ProfileStatItem(value: "45", title: "Gönderi")
        }
        .padding(.vertical, 16).background(Color.white).cornerRadius(16).padding(.horizontal).shadow(color: .black.opacity(0.02), radius: 6, x: 0, y: 3)
    }
}

// İSMİ DEĞİŞTİRİLEN YAPI
struct ProfileStatItem: View {
    var value: String; var title: String
    var body: some View {
        VStack(spacing: 4) {
            Text(value).font(.system(size: 20, weight: .bold)).foregroundColor(Color(hex: "345C72"))
            Text(title).font(.system(size: 13, weight: .medium)).foregroundColor(.gray)
        }.frame(maxWidth: .infinity)
    }
}

struct BadgesSection: View {
    let badges = [("hands.sparkles.fill", "Yardımsever", "FFD8CE", "A36653"), ("flame.fill", "Aktif Anne", "FDEFEF", "E53935"), ("heart.text.square.fill", "Deneyimli", "EBF5EC", "298A53")]
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Topluluk Rozetleri").font(.system(size: 16, weight: .bold)).foregroundColor(Color(hex: "333333")).padding(.horizontal)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(badges, id: \.1) { badge in
                        HStack(spacing: 6) { Image(systemName: badge.0).foregroundColor(Color(hex: badge.3)); Text(badge.1).font(.system(size: 13, weight: .bold)).foregroundColor(Color(hex: badge.3)) }
                        .padding(.horizontal, 12).padding(.vertical, 8).background(Color(hex: badge.2)).cornerRadius(20)
                    }
                }.padding(.horizontal)
            }
        }
    }
}

struct BabyDevelopmentSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Mira'nın Gelişimi").font(.system(size: 18, weight: .bold)).foregroundColor(Color(hex: "345C72"))
                Spacer()
                Button(action: {}) { Text("Düzenle").font(.system(size: 14, weight: .bold)).foregroundColor(Color(hex: "A36653")) }
            }.padding(.horizontal)
            VStack(spacing: 12) {
                InfoRow(icon: "calendar", title: "Doğum Tarihi", value: "12 Nisan 2026", color: "345C72"); Divider()
                InfoRow(icon: "scalemass.fill", title: "Güncel Kilo", value: "6.2 kg", color: "298A53"); Divider()
                InfoRow(icon: "ruler.fill", title: "Güncel Boy", value: "61 cm", color: "E58E26"); Divider()
                InfoRow(icon: "tshirt.fill", title: "Kullandığı Beden", value: "3-6 Ay", color: "345C72")
            }
            .padding().background(Color.white).cornerRadius(16).padding(.horizontal).shadow(color: .black.opacity(0.02), radius: 6, x: 0, y: 3)
        }
    }
}

struct InfoRow: View {
    var icon: String; var title: String; var value: String; var color: String
    var body: some View { HStack { RoundedRectangle(cornerRadius: 8).fill(Color(hex: color).opacity(0.1)).frame(width: 36, height: 36).overlay(Image(systemName: icon).foregroundColor(Color(hex: color)).font(.system(size: 16))); Text(title).font(.system(size: 15, weight: .medium)).foregroundColor(.gray).padding(.leading, 8); Spacer(); Text(value).font(.system(size: 15, weight: .bold)).foregroundColor(Color(hex: "333333")) } }
}

struct ActionButtonsSection: View {
    var body: some View {
        VStack(spacing: 12) {
            Button(action: {}) { Text("Profili Paylaş").font(.system(size: 16, weight: .bold)).foregroundColor(.white).frame(maxWidth: .infinity).padding(.vertical, 16).background(Color(hex: "345C72")).cornerRadius(12) }
            Button(action: {}) { Text("Ayarlar").font(.system(size: 16, weight: .bold)).foregroundColor(Color(hex: "345C72")).frame(maxWidth: .infinity).padding(.vertical, 16).background(Color.white).cornerRadius(12).overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.3), lineWidth: 1)) }
        }.padding(.horizontal).padding(.top, 10)
    }
}

struct BabyProfileView_Previews: PreviewProvider {
    static var previews: some View { BabyProfileView() }
}
