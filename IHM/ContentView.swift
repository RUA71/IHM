//
//  ContentView.swift
//  IHM
//
//  Created by Andrea on 15/06/2026.
//

import SwiftUI
import SwiftData

/// Root view: shows a splash screen on launch, then registration or the main tab bar.
struct ContentView: View {
    // @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var authVM: AuthViewModel
    @EnvironmentObject var eventsVM: EventsViewModel

    /// Controls splash visibility; starts as `true` and is dismissed once
    /// the remote fetch completes or 5 seconds have elapsed.
    @State private var showSplash = true

    var body: some View {
        ZStack {
            if showSplash {
                SplashScreenView()
                    .transition(.opacity)
                    .zIndex(1)
            } else {
                ZStack {

                    Group {
                        if !authVM.isRegistered {
                            RegistrationView()
                        } else if let user = authVM.currentUser {
                            MainTabView(user: user)
                        } else {
                            RegistrationView()
                        }
                    }
                }
                .transition(.opacity)
                .zIndex(0)
            }
        }
        .animation(.easeInOut(duration: 0.5), value: showSplash)
        .preferredColorScheme(.dark)
        .task {
            // Hard cap: dismiss the splash after 5 seconds at the latest.
            try? await Task.sleep(for: .seconds(5))
            showSplash = false
        }
        .onChange(of: authVM.isLoading) { _, isLoading in
            // Dismiss as soon as the remote fetch completes.
            if !isLoading {
                showSplash = false
            }
        }
    }
}

/// The main tab bar shown after login.
struct MainTabView: View {
    let user: User
    @EnvironmentObject var eventsVM: EventsViewModel
    @EnvironmentObject var authVM: AuthViewModel

    var body: some View {
        TabView {
            MapView()
                .tabItem {
                    Label("Events", systemImage: "calendar")
                }

            ChatListView()
                .tabItem {
                    Label("Chat", systemImage: "bubble.left.and.bubble.right")
                }

            SettingsMenuView(user: user)
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
        .crownTabChrome()
        .onAppear {
            SyncManager.shared.startSync()
        }
        .onDisappear {
            SyncManager.shared.stopSync()
        }
    }


}

#Preview {
    ContentView()
        .environmentObject(AuthViewModel())
        .environmentObject(EventsViewModel())
}
