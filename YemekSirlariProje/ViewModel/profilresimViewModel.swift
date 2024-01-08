//
//  profilresimViewModel.swift
//  YemekSirlariProje
//
//  Created by MURAT BAŞER on 4.01.2024.
//

import SwiftUI

struct ProfilResmiSec : UIViewControllerRepresentable {
    @Binding var secilenProfilResmi : UIImage?
    @Binding var profilResimSecildiMi : Bool
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        return picker
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    
    }
    
    func makeCoordinator() -> ProfilCoordinator {
        return ProfilCoordinator(self)
    }
}
class ProfilCoordinator : NSObject,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let parent : ProfilResmiSec
    init(_ picker : ProfilResmiSec){
        parent = picker
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("profil resim seçildi")
        if let resim = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            DispatchQueue.main.async {
                self.parent.secilenProfilResmi = resim
            }
        }
        self.parent.profilResimSecildiMi = false
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("profil resmi seçilmedi")
    }
}

