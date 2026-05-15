import SwiftUI

struct SubscriptionView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var selectedTab: Int // EKLENDİ
    
    var body: some View {
        VStack(spacing: 0) {
            // Üst Navigasyon Barı
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    HStack(spacing: 4) {
                        Image(systemName: "chevron.left")
                        Text("Geri")
                    }
                    .foregroundColor(Color(hex: "345C72"))
                    .font(.system(size: 16, weight: .medium))
                }
                Spacer()
                Text("Aboneliğim").font(.system(size: 20, weight: .bold)).foregroundColor(.black).offset(x: -10)
                Spacer()
                HStack(spacing: 12) { Image(systemName: "square").foregroundColor(.gray); Image(systemName: "square").foregroundColor(.gray) }
            }
            .padding(.horizontal).padding(.top, 10).padding(.bottom, 20)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    MainSubscriptionCard(selectedTab: $selectedTab, dismissAction: dismiss) // DEĞİŞTİRİLDİ
                    AIBannerView()
                    
                    HStack { Text("BU AYKİ PAKET").font(.system(size: 12, weight: .bold)).foregroundColor(.gray); Spacer() }.padding(.top, 5)
                    
                    PackageDetailsCard()
                    PriceSummaryCard()
                    NextDeliveryCard()
                    ActionButtonsView().padding(.top, 5)
                }
                .padding(.horizontal).padding(.bottom, 30)
            }
        }
        .background(Color(UIColor.systemBackground))
        .navigationBarBackButtonHidden(true)
    }
}

// MARK: - Subviews
struct MainSubscriptionCard: View {
    @Binding var selectedTab: Int // EKLENDİ
    var dismissAction: DismissAction // EKLENDİ
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top) {
                
                // PROFİL İKONU BUTONA ÇEVRİLDİ
                Button(action: {
                    selectedTab = 3 // Profil sekmesine ayarla
                    dismissAction() // Bu sayfayı kapatıp geri dön
                }) {
                    Circle().fill(Color(hex: "FFD8CE")).frame(width: 50, height: 50).overlay(Image(systemName: "face.smiling").foregroundColor(.gray.opacity(0.5)))
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Mira'nın Paketi").font(.system(size: 18, weight: .bold)).foregroundColor(.white)
                    Text("Şu an 3. ay • yakında 4. ay 🎉").font(.system(size: 13, weight: .medium)).foregroundColor(.white.opacity(0.8))
                }.padding(.leading, 8)
                Spacer()
                VStack(spacing: 2) { Text("7").font(.system(size: 18, weight: .heavy)); Text("AYDIR\nÜYE").font(.system(size: 9, weight: .bold)).multilineTextAlignment(.center) }.foregroundColor(Color(hex: "E5F0F9")).padding(.vertical, 8).padding(.horizontal, 12).background(Color.white.opacity(0.2)).cornerRadius(8)
            }.padding()
            
            Divider().background(Color.white.opacity(0.3)).padding(.horizontal)
            HStack {
                StatItem(value: "38 sa", title: "Tasarruf"); Divider().background(Color.white.opacity(0.3)).frame(height: 30)
                StatItem(value: "7 kutu", title: "Teslimat"); Divider().background(Color.white.opacity(0.3)).frame(height: 30)
                StatItem(value: "3", title: "Marka")
            }.padding(.vertical, 12)
        }.background(Color(hex: "345C72")).cornerRadius(16)
    }
}

struct StatItem: View {
    var value: String; var title: String
    var body: some View { VStack(spacing: 2) { Text(value).font(.system(size: 14, weight: .bold)).foregroundColor(.white); Text(title).font(.system(size: 12, weight: .medium)).foregroundColor(.white.opacity(0.7)) }.frame(maxWidth: .infinity) }
}

struct AIBannerView: View {
    var body: some View { HStack(alignment: .top, spacing: 12) { RoundedRectangle(cornerRadius: 6).fill(Color(hex: "345C72")).frame(width: 24, height: 24).overlay(Image(systemName: "sparkles").font(.system(size: 12)).foregroundColor(.white)); Text("**babie+ yapay zeka:** Mira 4. aya geçmek üzere! Bu ay paketine **3 adet zıbın** eklendi, beden otomatik güncellendi.").font(.system(size: 13)).foregroundColor(Color(hex: "A36653")).lineSpacing(2) }.padding().background(Color(hex: "FFF0E8")).cornerRadius(12).overlay(RoundedRectangle(cornerRadius: 12).stroke(Color(hex: "F5D0C5"), lineWidth: 1)) }
}

struct PackageDetailsCard: View {
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 4) { Text("PLUS PAKET").font(.system(size: 11, weight: .bold)).foregroundColor(Color(hex: "567C92")); Text("Ağustos 2026 Teslimatı").font(.system(size: 18, weight: .bold)).foregroundColor(Color(hex: "345C72")) }.frame(maxWidth: .infinity, alignment: .leading).padding().background(Color(hex: "EEF3F6"))
            VStack(spacing: 0) {
                PackageItemRow(iconColor: "FFD8CE", brand: "MOLFİX", product: "Bebek Bezi", detail: "Beden 3 • ", count: "120 adet"); Divider().padding(.leading, 70)
                PackageItemRow(iconColor: "D4E5EC", brand: "SLEEPY", product: "Islak Mendil", detail: "Hassas • ", count: "6 paket"); Divider().padding(.leading, 70)
                PackageItemRow(iconColor: "FFD8CE", brand: "MOLFİX", product: "Bez Örtü", detail: "Tek kullanım • ", count: "30 adet"); Divider().padding(.leading, 70)
                HStack(alignment: .top, spacing: 16) { RoundedRectangle(cornerRadius: 12).fill(Color(hex: "F2F5F7")).frame(width: 50, height: 50).overlay(Image(systemName: "tshirt.fill").foregroundColor(.gray.opacity(0.5))); VStack(alignment: .leading, spacing: 4) { Text("4. AY HEDİYESİ 🎀").font(.system(size: 10, weight: .bold)).foregroundColor(Color(hex: "567C92")); Text("Pamuklu Zıbın").font(.system(size: 15, weight: .bold)).foregroundColor(Color(hex: "333333")); HStack(spacing: 0) { Text("Beden 3-6 ay • ").font(.system(size: 12)).foregroundColor(.gray); Text("3 adet").font(.system(size: 12, weight: .bold)).foregroundColor(.black) }; Text("✦ babie+ sürprizi").font(.system(size: 10, weight: .bold)).foregroundColor(Color(hex: "A36653")).padding(.horizontal, 8).padding(.vertical, 4).background(Color(hex: "FFD8CE")).cornerRadius(4).padding(.top, 2) }; Spacer() }.padding()
            }.background(Color.white)
        }.cornerRadius(16).overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray.opacity(0.2), lineWidth: 1))
    }
}

struct PackageItemRow: View {
    var iconColor: String; var brand: String; var product: String; var detail: String; var count: String
    var body: some View { HStack(alignment: .center, spacing: 16) { RoundedRectangle(cornerRadius: 12).fill(Color(hex: iconColor)).frame(width: 50, height: 50).overlay(Image(systemName: "cube.box.fill").foregroundColor(.white)); VStack(alignment: .leading, spacing: 4) { Text(brand).font(.system(size: 10, weight: .bold)).foregroundColor(Color(hex: "567C92")); Text(product).font(.system(size: 15, weight: .bold)).foregroundColor(Color(hex: "333333")); HStack(spacing: 0) { Text(detail).font(.system(size: 12)).foregroundColor(.gray); Text(count).font(.system(size: 12, weight: .bold)).foregroundColor(.black) } }; Spacer() }.padding() }
}

struct PriceSummaryCard: View {
    var body: some View { VStack(spacing: 12) { PriceRow(title: "Paket fiyatı", value: "₺1.099", valueColor: .black); PriceRow(title: "Zıbın sürprizi", value: "Hediye 🎁", valueColor: Color(hex: "298A53")); PriceRow(title: "Kargo", value: "Ücretsiz", valueColor: Color(hex: "298A53")); HStack { Text("Toplam").font(.system(size: 16, weight: .bold)).foregroundColor(Color(hex: "345C72")); Spacer(); Text("₺1.199").font(.system(size: 20, weight: .bold)).foregroundColor(Color(hex: "345C72")) }.padding().background(Color(hex: "EEF3F6")).cornerRadius(12) }.padding().background(Color.white).cornerRadius(16).overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray.opacity(0.2), lineWidth: 1)) }
}

struct PriceRow: View { var title: String; var value: String; var valueColor: Color; var body: some View { HStack { Text(title).font(.system(size: 14)).foregroundColor(.gray); Spacer(); Text(value).font(.system(size: 14, weight: .bold)).foregroundColor(valueColor) }.padding(.horizontal) } }

struct NextDeliveryCard: View {
    var body: some View { HStack(spacing: 12) { Image(systemName: "square").foregroundColor(Color(hex: "298A53")).font(.system(size: 20)); VStack(alignment: .leading, spacing: 2) { Text("Sonraki teslimat: 14 Ağustos").font(.system(size: 14, weight: .bold)).foregroundColor(.black); Text("5 gün sonra • Kargo takibi aktif").font(.system(size: 12)).foregroundColor(.gray) }; Spacer() }.padding().background(Color(hex: "EBF5EC")).cornerRadius(12).overlay(RoundedRectangle(cornerRadius: 12).stroke(Color(hex: "C5E1CD"), lineWidth: 1)) }
}

struct ActionButtonsView: View {
    var body: some View { VStack(spacing: 12) { Button(action: {}) { Text("Aboneliği Güncelle").font(.system(size: 16, weight: .bold)).foregroundColor(.white).frame(maxWidth: .infinity).padding().background(Color(hex: "345C72")).cornerRadius(12) }; Button(action: {}) { Text("Aboneliği Duraklat").font(.system(size: 16, weight: .medium)).foregroundColor(.gray).frame(maxWidth: .infinity).padding().background(Color.white).cornerRadius(12).overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.3), lineWidth: 1)) }; Text("Sonraki yenileme: 1 Eylül 2026").font(.system(size: 11)).foregroundColor(.gray).padding(.top, 4) } }
}

struct SubscriptionView_Previews: PreviewProvider {
    static var previews: some View { SubscriptionView(selectedTab: .constant(0)) }
}
