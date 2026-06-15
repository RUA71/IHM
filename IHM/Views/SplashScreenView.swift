import SwiftUI

/// Full-screen splash that is shown at launch until remote data has been
/// fetched (or 5 seconds have elapsed, whichever comes first).
struct SplashScreenView: View {
    @State private var logoScale: CGFloat = 0.6
    @State private var logoOpacity: Double = 0
    @State private var subtitleOpacity: Double = 0
    @State private var spinnerOpacity: Double = 0

    var body: some View {
        ZStack {
            Color(.systemBackground).ignoresSafeArea()

            VStack(spacing: 0) {
                Spacer()

                // ── Crown emblem ──────────────────────────────────────────
                ZStack {
                    Circle()
                        .fill(Color.yellow.opacity(0.18))
                        .frame(width: 160, height: 160)

                    Circle()
                        .strokeBorder(
                            LinearGradient(
                                colors: [.yellow, .secondary],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 3
                        )
                        .frame(width: 160, height: 160)

                    Image(systemName: "crown.fill")
                        .font(.system(size: 64))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.yellow, .secondary],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .shadow(color: Color.yellow.opacity(0.55), radius: 18)
                }
                .scaleEffect(logoScale)
                .opacity(logoOpacity)

                // ── App title ─────────────────────────────────────────────
                VStack(spacing: 8) {
                    Text("Italia Hobby")
                        .font(.largeTitle)
                        .foregroundColor(.yellow)
                        .tracking(2)

                    Text("Motociclismo")
                        .font(.title2)
                        .foregroundColor(.white)
                        .tracking(4)

                    Rectangle()
                        .fill(
                            LinearGradient(
                                colors: [.clear, .yellow, .clear],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(height: 1)
                        .padding(.horizontal, 48)
                        .padding(.top, 6)

                    Text("The Italian Riders' Brotherhood")
                        .font(.subheadline)
                        .foregroundColor(Color.white.opacity(0.75))
                        .italic()
                        .padding(.top, 4)
                }
                .opacity(subtitleOpacity)
                .padding(.top, 28)

                Spacer()

                // ── Loading indicator ─────────────────────────────────────
                VStack(spacing: 10) {
                    ProgressView()
                        .tint(.yellow)
                        .scaleEffect(1.1)

                    Text("Entering the realm…")
                        .font(.caption)
                        .foregroundColor(Color.white.opacity(0.65))
                }
                .opacity(spinnerOpacity)
                .padding(.bottom, 52)
            }
        }
        .ignoresSafeArea()
        .onAppear {
            withAnimation(.easeOut(duration: 0.7)) {
                logoScale = 1.0
                logoOpacity = 1.0
            }
            withAnimation(.easeOut(duration: 0.9).delay(0.35)) {
                subtitleOpacity = 1.0
            }
            withAnimation(.easeIn(duration: 0.5).delay(0.7)) {
                spinnerOpacity = 1.0
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
