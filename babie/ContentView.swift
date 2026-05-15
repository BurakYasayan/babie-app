import SwiftUI

// MARK: - Root View (Ana Yönlendirici)
struct ContentView: View {
    @State private var selectedTab: Int = 0
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Seçili sekmeye göre gösterilecek içerik
                ZStack {
                    switch selectedTab {
                    case 0:
                        HomeDashboardView(selectedTab: $selectedTab) // Binding eklendi
                    case 1:
                        CommunityView() // Topluluk sayfan
                    case 2:
                        OrdersView() // Siparişler sayfan
                    case 3:
                        BabyProfileView() // babie+ (Profil) sekmesi
                    default:
                        HomeDashboardView(selectedTab: $selectedTab)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                Divider()
                CustomTabBar(selectedTab: $selectedTab)
            }
            .ignoresSafeArea(.keyboard)
            .background(Color(hex: "F9FAFC"))
        }
    }
}

// MARK: - Home Dashboard
struct HomeDashboardView: View {
    @Binding var selectedTab: Int // Binding eklendi
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0) {
                VStack(spacing: 20) {
                    HomeHeaderView(selectedTab: $selectedTab) // Binding eklendi
                    HomeGreetingView()
                }
                .padding(.horizontal).padding(.top, 20).padding(.bottom, 30)
                .background(Color(hex: "345C72"))
                
                VStack(spacing: 24) {
                    DashboardAIBanner().offset(y: -20).padding(.bottom, -20)
                    ActivePackageSection()
                    StatsSection()
                }
                .padding(.horizontal).padding(.bottom, 30)
            }
        }
        .ignoresSafeArea(edges: .top)
    }
}

// MARK: - Home Subviews
struct HomeHeaderView: View {
    @Binding var selectedTab: Int // Binding eklendi
    
    var body: some View {
        HStack {
            HStack(spacing: 12) {
                Circle().fill(Color(hex: "FFD8CE")).frame(width: 44, height: 44).overlay(Text("AY").font(.system(size: 16, weight: .bold)).foregroundColor(Color(hex: "A36653")))
                VStack(alignment: .leading, spacing: 2) {
                    Text("Ayşe Yılmaz").font(.system(size: 16, weight: .bold)).foregroundColor(.white)
                    Text("Bebek: Mira • 4 ay").font(.system(size: 12)).foregroundColor(.white.opacity(0.8))
                }
            }
            .padding(.horizontal, 12).padding(.vertical, 8).background(Color.white.opacity(0.15)).cornerRadius(30)
            
            Spacer()
            
            HStack(spacing: 12) {
                CircleIconButton(icon: "bell")
                
                // Sağ Üstteki İkon -> Abonelik Sayfasına Binding ile Yönlendirir
                NavigationLink(destination: SubscriptionView(selectedTab: $selectedTab)) {
                    ZStack {
                        Circle().fill(Color.white.opacity(0.15)).frame(width: 44, height: 44)
                        Image(systemName: "bag").font(.system(size: 18, weight: .medium)).foregroundColor(.white)
                    }
                }
            }
        }
        .padding(.top, 40)
    }
}

struct CircleIconButton: View {
    var icon: String
    var body: some View {
        Button(action: {}) {
            ZStack { Circle().fill(Color.white.opacity(0.15)).frame(width: 44, height: 44); Image(systemName: icon).font(.system(size: 18, weight: .medium)).foregroundColor(.white) }
        }
    }
}

struct HomeGreetingView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Günaydın, Ayşe").font(.system(size: 16, weight: .medium)).foregroundColor(.white.opacity(0.9))
            Text("Mira için bu hafta\nher şey hazır.").font(.system(size: 28, weight: .bold)).foregroundColor(.white).lineSpacing(2)
            Text("Sonraki teslimat 3 gün sonra").font(.system(size: 16)).foregroundColor(.white.opacity(0.8)).padding(.top, 4)
        }.frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct DashboardAIBanner: View {
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            RoundedRectangle(cornerRadius: 12).fill(Color(hex: "345C72")).frame(width: 48, height: 48).overlay(Image(systemName: "sparkles").font(.system(size: 20)).foregroundColor(.white))
            VStack(alignment: .leading, spacing: 4) {
                Text("babie+ yapay zeka").font(.system(size: 14, weight: .bold)).foregroundColor(Color(hex: "A36653"))
                Text("Mira 4. ayına girdi — bez bedenini güncelledim, yeni paket hazır!").font(.system(size: 14)).foregroundColor(Color(hex: "345C72")).lineSpacing(2)
            }
            Spacer()
        }.padding().background(Color(hex: "FFEBE5")).cornerRadius(16)
    }
}

struct ActivePackageSection: View {
    var body: some View {
        VStack(spacing: 16) {
            HStack { Text("Aktif paketiniz").font(.system(size: 18, weight: .bold)).foregroundColor(Color(hex: "345C72")); Spacer(); Button(action: {}) { Text("Düzenle").font(.system(size: 14, weight: .medium)).foregroundColor(Color(hex: "345C72")) } }
            HStack(spacing: 12) {
                PackageOptionCard(tagText: "Aktif", tagBg: "345C72", tagColor: "FFFFFF", title: "Temel Paket", subtitle: "Aylık bez + ıslak mendil kombinasyonu", price: "₺799", bullets: ["120 adet bez", "4 paket mendil"], isActive: true)
                PackageOptionCard(tagText: "Popüler", tagBg: "FFD8CE", tagColor: "A36653", title: "Plus Paket", subtitle: "Daha fazla bez kapasitesi", price: "₺999", bullets: ["200 adet bez", "6 paket mendil"], isActive: false)
            }
        }
    }
}

struct PackageOptionCard: View {
    var tagText: String; var tagBg: String; var tagColor: String; var title: String; var subtitle: String; var price: String; var bullets: [String]; var isActive: Bool
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(tagText).font(.system(size: 12, weight: .bold)).foregroundColor(Color(hex: tagColor)).padding(.horizontal, 10).padding(.vertical, 4).background(Color(hex: tagBg)).cornerRadius(12)
            VStack(alignment: .leading, spacing: 4) { Text(title).font(.system(size: 16, weight: .bold)).foregroundColor(Color(hex: "345C72")); Text(subtitle).font(.system(size: 12)).foregroundColor(.gray).lineLimit(2) }
            HStack(alignment: .firstTextBaseline, spacing: 2) { Text(price).font(.system(size: 24, weight: .heavy)).foregroundColor(Color(hex: "345C72")); Text("/ay").font(.system(size: 14)).foregroundColor(.gray) }
            VStack(alignment: .leading, spacing: 6) { ForEach(bullets, id: \.self) { bullet in HStack(spacing: 6) { Circle().fill(Color.gray).frame(width: 4, height: 4); Text(bullet).font(.system(size: 13)).foregroundColor(.gray) } } }
            Spacer()
        }.padding().frame(maxWidth: .infinity, alignment: .leading).background(isActive ? Color(hex: "EEF3F6") : Color.white).cornerRadius(16).overlay(RoundedRectangle(cornerRadius: 16).stroke(isActive ? Color(hex: "345C72") : Color.gray.opacity(0.2), lineWidth: isActive ? 2 : 1))
    }
}

struct StatsSection: View {
    var body: some View {
        HStack(spacing: 12) { StatBlock(value: "4.5 sa", description: "Haftalık tasarruf"); StatBlock(value: "3 ay", description: "Aktif üyelik") }
    }
}

struct StatBlock: View {
    var value: String; var description: String
    var body: some View {
        VStack(spacing: 4) { Text(value).font(.system(size: 24, weight: .bold)).foregroundColor(Color(hex: "345C72")); Text(description).font(.system(size: 13)).foregroundColor(Color(hex: "345C72").opacity(0.8)) }
        .frame(maxWidth: .infinity).padding(.vertical, 20).background(Color(hex: "E8F0F4")).cornerRadius(12)
    }
}

// MARK: - Tab Bar
struct CustomTabBar: View {
    @Binding var selectedTab: Int
    var body: some View {
        HStack {
            TabBarButton(icon: "house", title: "Ana Sayfa", index: 0, selectedTab: $selectedTab); Spacer()
            TabBarButton(icon: "cube.box", title: "Topluluk", index: 1, selectedTab: $selectedTab); Spacer()
            TabBarButton(icon: "clock", title: "Siparişler", index: 2, selectedTab: $selectedTab); Spacer()
            Button(action: { selectedTab = 3 }) {
                VStack(spacing: 4) {
                    RoundedRectangle(cornerRadius: 6).fill(selectedTab == 3 ? Color(hex: "345C72") : Color.gray).frame(width: 26, height: 26).overlay(Text("b+").font(.system(size: 14, weight: .bold)).foregroundColor(.white))
                    Text("babie").font(.system(size: 11, weight: .bold)).foregroundColor(selectedTab == 3 ? Color(hex: "345C72") : .gray)
                }
            }.frame(maxWidth: .infinity)
        }
        .padding(.horizontal, 30).padding(.top, 10).padding(.bottom, 10).background(Color.white)
    }
}

struct TabBarButton: View {
    var icon: String; var title: String; var index: Int; @Binding var selectedTab: Int
    var body: some View {
        Button(action: { selectedTab = index }) {
            VStack(spacing: 4) { Image(systemName: icon).font(.system(size: 22)).foregroundColor(selectedTab == index ? Color(hex: "345C72") : .gray); Text(title).font(.system(size: 11, weight: selectedTab == index ? .semibold : .regular)).foregroundColor(selectedTab == index ? Color(hex: "345C72") : .gray) }
        }.frame(maxWidth: .infinity)
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0; Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default: (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(.sRGB, red: Double(r)/255, green: Double(g)/255, blue: Double(b)/255, opacity: Double(a)/255)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View { ContentView() }
}
