//
//  MCBrowserView.swift
//  Snake-SwiftUI
//
//  Created by Jordan Christensen on 1/13/22.
//

import SwiftUI
import MultipeerConnectivity

struct MCBrowserView: UIViewControllerRepresentable {
    @Binding private var session: MCSession
    
    init(session: Binding<MCSession>) {
        self._session = session
    }
    
    func makeUIViewController(context: Context) -> MCBrowserViewController {
        let browser = MCBrowserViewController(serviceType: MultiplayerViewModel.assistentServiceType, session: session)
        
        updateUIViewController(browser, context: context)
        
        return browser
    }
    
    func updateUIViewController(_ browser: MCBrowserViewController, context: Context) {
        browser.delegate = context.coordinator
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject, MCBrowserViewControllerDelegate {
        func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
            
        }
        
        func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
            
        }
    }
}

struct MCBrowserView_Previews: PreviewProvider {
    static var previews: some View {
        MCBrowserView(session: .init(MCSession()))
    }
}
