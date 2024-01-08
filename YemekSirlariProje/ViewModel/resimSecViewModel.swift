//
//  resimSecViewModel.swift
//  YemekSirlariProje
//
//  Created by MURAT BAŞER on 4.01.2024.
//

import Foundation
import SwiftUI

struct ResimSec : UIViewControllerRepresentable {
    @Binding var secilenResim : UIImage?
    @Binding var resimSecildiMi : Bool
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        return picker
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
}
class Coordinator : NSObject,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let parent : ResimSec
    init(_ picker : ResimSec){
        self.parent = picker
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("resim seçildi")
        if let resim = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            DispatchQueue.main.async {
                self.parent.secilenResim = resim
            }
        }
        parent.resimSecildiMi = false
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("resim seçilmedi")
        parent.resimSecildiMi = false
    }
}

