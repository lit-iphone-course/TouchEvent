//
//  ViewController.swift
//  TouchEvent
//
//  Created by Owner on 2023/09/24.
//

import UIKit
import PhotosUI

class ViewController: UIViewController, PHPickerViewControllerDelegate {
    
    //背景画像を表示させるimageView
    @IBOutlet var backgroundImageView: UIImageView!
    
    //選択されたスタンプの画像名
    var selectedImageName: String = "flower"
    
    //スタンプを表示させるimageViewの配列
    var imageViewArray: [UIImageView] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //タッチされた座標を取得
        let touch: UITouch = touches.first!
        let location: CGPoint = touch.location(in: view)
        
        //imageViewを用意してスタンプ画像と座標をセット
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 70, height: 70))
        imageView.image = UIImage(named: selectedImageName)
        imageView.center = CGPoint(x: location.x, y: location.y)
        
        //タッチされた位置にスタンプ画像を追加
        view.addSubview(imageView)
        
        //スタンプを表示させるimageViewの配列に追加
        imageViewArray.append(imageView)
    }
    
    @IBAction func selectImage1() {
        selectedImageName = "flower"
    }
    
    @IBAction func selectImage2() {
        selectedImageName = "cloud"
    }
    
    @IBAction func selectImage3() {
        selectedImageName = "heart"
    }
    
    @IBAction func selectImage4() {
        selectedImageName = "star"
    }
    
    @IBAction func changeBackground() {
        //PHPickerViewControllerを用意
        var configuration = PHPickerConfiguration()
        
        //選択できるアセットタイプを画像に限定
        let filter = PHPickerFilter.images
        configuration.filter = filter
        let picker = PHPickerViewController(configuration: configuration)
        
        //デリゲートを設定
        picker.delegate = self
        
        //フォトライブラリを呼び出す
        present(picker, animated: true)
    }
    
    @IBAction func save() {
        //画面のスクリーンショットを撮影
        UIGraphicsBeginImageContextWithOptions(backgroundImageView.frame.size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()!
        context.translateBy(x: -backgroundImageView.frame.origin.x, y: -backgroundImageView.frame.origin.y)
        view.layer.render(in: context)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //フォトライブラリに保存
        UIImageWriteToSavedPhotosAlbum(screenshot!, nil, nil, nil)
    }
    
    @IBAction func undo() {
        //配列が空だったらここまでで処理を終了
        if imageViewArray.isEmpty { return }
        
        //配列の末尾の要素を削除
        imageViewArray.last!.removeFromSuperview()
        
        //スタンプを表示させるimageViewの配列の末尾の要素を削除
        imageViewArray.removeLast()
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        //選択された画像の情報を取得
        let itemProvider = results.first?.itemProvider
        
        //選択された画像を読み込み、背景にセット
        if let itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                DispatchQueue.main.async {
                    self.backgroundImageView.image = image as? UIImage
                }
            }
        }
        
        //フォトライブラリを閉じる
        dismiss(animated: true)
    }

}

