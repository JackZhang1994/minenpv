//
//  OcForSwfManage.swift
//  qibaijiasu
//
//  Created by yuany on 2023/12/24.
//

import UIKit

class OcForSwfManage: NSObject {
    
   
    var status : VPNManager.Status!{
        didSet(o) {
            updateConnectButton()
        }
    }
    
//    @objc var vpnStatus = VPNManager.shared.status;
    
    override init() {
    
        self.status = VPNManager.shared.status
    }
    
    @objc func getVpnStatus () -> Int {//0 1 2 3
        if(VPNManager.shared.status == .off){
            return 0;
        }else if(VPNManager.shared.status == .connecting){
            return 1
        }else if(VPNManager.shared.status == .disconnecting){
            return 2
        }else if(VPNManager.shared.status == .on){
            return 3
        }else{
            return 4
        }
       
    }
    
    @objc func setVPNState(){//初始状态
        self.status = VPNManager.shared.status
    }
    @objc func setVPNCreat(name:String,address:String,port:Int,crypto:String,password:String,isStatus:Bool){
        //isStatus = true,已开启
        var cryint = VPNManager.Crypto.AES256CFB
        if(crypto == "aes-256-cfb"){
            cryint = VPNManager.Crypto.AES256CFB
        }else if(crypto == "aes-128-cfb"){
            cryint = VPNManager.Crypto.AES128CFB
        }else if(crypto == "aes-192-cfb"){
            cryint = VPNManager.Crypto.AES192CFB
        }
        
        let config = VPNManager.Config(name: name, address: address, port: port, crypto: cryint, password: password)
        
        if(isStatus==false){
            VPNManager.shared.connect(with: config)
        }else{
            VPNManager.shared.disconnect()
        }
    }
    
    func updateConnectButton(){
        switch status {
        case .connecting:
            print("connecting")
        case .disconnecting:
            print("disconnect")
        case .on:
            print("Disconnect")
        case .off:
            print("Connect")
        case .none:
            print("Disconnect")
        }
        
        
    }
    
}
