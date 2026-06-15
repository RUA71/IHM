import SwiftUI

/// Registration screen shown to new users on first launch.
struct RegistrationView: View {
    @EnvironmentObject var authVM: AuthViewModel

    @State private var nickname = ""
    @State private var name = ""
    @State private var surname = ""
    @State private var city = ""
    @State private var country = ""
    
    @State private var motorbikeBrand = ""
    @State private var motorbikeModel = ""
    @State private var motorbikeType = ""

    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemBackground)
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 20) {
                        // Replaced CrownHeroBanner with VStack containing Image and Texts
                        VStack(spacing: 8) {
                            Image(systemName: "crown.fill")
                                .font(.system(size: 60))
                                .foregroundColor(.yellow)
                            Text("Welcome, Rider")
                                .font(.title)
                                .bold()
                            Text("A Defender of the Crown inspired hall for joining the club and preparing your next journey.")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                        }
                        .padding(.top, 16)
                        .padding(.horizontal, 20)

                        // Personal Data Section
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .fill(Color.white.opacity(0.1))
                            .overlay(
                                VStack(alignment: .leading, spacing: 10) {
                                    Text("Personal Data")
                                        .font(.headline)
                                        .bold()
                                    Text("Share the name you ride under and the land you call home.")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                    
                                    TextField("Nickname *", text: $nickname)
                                        .textInputAutocapitalization(.words)
                                        .autocorrectionDisabled(true)
                                        .textFieldStyle(.roundedBorder)
                                    TextField("First Name", text: $name)
                                        .textInputAutocapitalization(.words)
                                        .textFieldStyle(.roundedBorder)
                                    TextField("Last Name", text: $surname)
                                        .textInputAutocapitalization(.words)
                                        .textFieldStyle(.roundedBorder)
                                    TextField("City *", text: $city)
                                        .textInputAutocapitalization(.words)
                                        .textFieldStyle(.roundedBorder)
                                    TextField("Country *", text: $country)
                                        .textInputAutocapitalization(.words)
                                        .textFieldStyle(.roundedBorder)
                                }
                                .padding(16)
                            )
                            .padding(.horizontal, 20)

                        // Motorcycle Section
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .fill(Color.white.opacity(0.1))
                            .overlay(
                                VStack(alignment: .leading, spacing: 10) {
                                    Text("Motorcycle")
                                        .font(.headline)
                                        .bold()
                                    Text("Tell the club which steed will join the procession.")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                    
                                    TextField("Brand *", text: $motorbikeBrand)
                                        .textInputAutocapitalization(.words)
                                        .textFieldStyle(.roundedBorder)
                                    TextField("Model *", text: $motorbikeModel)
                                        .textInputAutocapitalization(.words)
                                        .textFieldStyle(.roundedBorder)
                                    TextField("Type", text: $motorbikeType)
                                        .textInputAutocapitalization(.words)
                                        .textFieldStyle(.roundedBorder)
                                }
                                .padding(16)
                            )
                            .padding(.horizontal, 20)

                        Button(action: register) {
                            if authVM.isLoading {
                                ProgressView()
                                    .accentColor(.blue)
                                    .frame(maxWidth: .infinity)
                            } else {
                                Text("Join the Court")
                                    .frame(maxWidth: .infinity)
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(!isFormValid || authVM.isLoading)
                        .opacity((!isFormValid || authVM.isLoading) ? 0.65 : 1)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 24)
                    }
                }
            }
            .navigationTitle("Welcome")
            .navigationBarTitleDisplayMode(.inline)
            .alert("Error", isPresented: errorBinding) {
                Button("OK", role: .cancel) { authVM.errorMessage = nil }
            } message: {
                Text(authVM.errorMessage ?? "")
            }
        }
    }

    private var isFormValid: Bool {
        !nickname.isEmpty && !city.isEmpty && !country.isEmpty &&
        !motorbikeBrand.isEmpty && !motorbikeModel.isEmpty
    }

    private var errorBinding: Binding<Bool> {
        Binding(
            get: { authVM.errorMessage != nil },
            set: { if !$0 { authVM.errorMessage = nil } }
        )
    }

    private func register() {
        Task {
            await authVM.register(
                nickname: nickname,
                name: name,
                surname: surname,
                city: city,
                country: country,
                motorbikeBrand: motorbikeBrand,
                motorbikeModel: motorbikeModel,
                motorbikeType: motorbikeType
            )
        }
    }
}

#Preview {
    RegistrationView()
        .environmentObject(AuthViewModel())
}
