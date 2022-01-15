//
//  MultiplayerViewModel.swift
//  Snake-SwiftUI
//
//  Created by Jordan Christensen on 1/10/22.
//

import SwiftUI
import MultipeerConnectivity
import Combine

enum MultiplayerViewState {
    case profile
    case matchMaking
    case startingMatch
}

class MultiplayerViewModel: NSObject, ObservableObject {
    var peerId: MCPeerID?
    var session: MCSession?
    var advertiser: MCAdvertiserAssistant?
    
    @Published var enemySnakes = [Snake]()
    
//    private var subscriptions = Set<AnyCancellable>()
    
    override init() {
        super.init()
        
        let id = MCPeerID(displayName: UIDevice.current.name)
        
        self.peerId = id
        self.session = MCSession(peer: id, securityIdentity: nil, encryptionPreference: .required)
    }
    
    func beginHosting() {
        guard let session = session else { return }

        advertiser = MCAdvertiserAssistant(serviceType: Self.assistentServiceType, discoveryInfo: nil, session: session)
        advertiser?.start()
    }
    
    static let assistentServiceType: String = "com.mazjap.snake-swiftui"
}

extension MultiplayerViewModel: MCSessionDelegate {
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        
    }
}
