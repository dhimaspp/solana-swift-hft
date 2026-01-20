//
//  ContentView.swift
//  SSHFTDemo
//
//  Created by Dhimaspp on 21/01/26.
//

import SwiftUI
import SolanaSwift

struct ContentView: View {
    // State untuk menampung log (biar tampil di layar HP)
    @State private var logs: [String] = ["System ready...", "Library: swift-solana-hft loaded."]
    @State private var generatedPubkey: String = "Not Connected"
    @State private var isProcessing = false
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all) // Background Hitam a la Terminal
            
            VStack(alignment: .leading, spacing: 20) {
                
                // Header
                HStack {
                    Text("Swift Solana HFT Terminal Demo")
                        .font(.headline)
                        .foregroundColor(.green)
                    Spacer()
                    Text("v1.0")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .padding(.top, 40)
                
                Divider().background(Color.green)
                
                // Main Action Area
                VStack(alignment: .leading) {
                    Text("STATUS: \(isProcessing ? "PROCESSING..." : "IDLE")")
                        .font(.system(.caption, design: .monospaced))
                        .foregroundColor(isProcessing ? .yellow : .gray)
                    
                    Text(generatedPubkey)
                        .font(.system(.title3, design: .monospaced))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .minimumScaleFactor(0.5)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                
                // Action Button
                Button(action: {
                    Task {
                        await generateWallet()
                    }
                }) {
                    HStack {
                        Image(systemName: "bolt.fill")
                        Text("TEST CORE LIBRARY")
                    }
                    .font(.system(.body, design: .monospaced))
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.black)
                    .cornerRadius(8)
                }
                
                Divider().background(Color.gray)
                
                // Console Logs View
                Text("DEBUG LOGS >")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 5) {
                        ForEach(logs, id: \.self) { log in
                            Text("> \(log)")
                                .font(.system(.caption, design: .monospaced))
                                .foregroundColor(.green.opacity(0.8))
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
                .frame(maxHeight: 200)
                .background(Color.black)
                .border(Color.gray.opacity(0.3))
                
                Spacer()
                
                HStack(alignment: .center) {
                    Text("This demo for Superteam purpose only.\n\nregards,\ndhimaspp")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .multilineTextAlignment(.center)
                }
                    
            }
            .padding()
        }
    }
    
    // Fungsi Test Integration
    func generateWallet() async {
        isProcessing = true
        addLog("Initializing KeyPair generation...")
        
        // Simulasi delay sedikit biar kelihatan prosesnya
        try? await Task.sleep(nanoseconds: 500_000_000)
        
        do {
            // Memanggil Core Library SolanaSwift
            // Note: Cek apakah KeyPair butuh parameter network/mnemonic di versi p2p-org
            // Ini contoh generic, sesuaikan jika compiler minta parameter
            let account = try await KeyPair(network: .mainnetBeta)
            
            let pubKey = account.publicKey.base58EncodedString
            
            generatedPubkey = pubKey
            addLog("Success! KeyPair Generated.")
            addLog("Pubkey: \(pubKey.prefix(8))...")
            addLog("Library Integration: STABLE")
            
        } catch {
            addLog("Error: \(error.localizedDescription)")
        }
        
        isProcessing = false
    }
    
    func addLog(_ message: String) {
        let timestamp = Date().formatted(date: .omitted, time: .standard)
        withAnimation {
            logs.append("[\(timestamp)] \(message)")
        }
    }
}

#Preview {
    ContentView()
}
