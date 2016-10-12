//
//  ViewController.swift
//  HelloFileSystem
//
//  Created by 洪德晟 on 2016/10/11.
//  Copyright © 2016年 洪德晟. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var myImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
//        findDocumentsURL()
//        findCaches()
//        findTemp()
//        saveString("hey what's up")
//        loadString()
//        let fruitArray = ["apple", "banana", "mango"]
//        saveArray(original: fruitArray)
//        loadArray()
//        saveDictionary()
//        loadDictionary()
//        saveImage(image: #imageLiteral(resourceName: "MyCat"))
//        loadImage()
//        creatFolder()
//        checkOutTmp()
//        checkOutIfItsFolder()
//        moveOrCopy()
//        let copyToThisPath = NSHomeDirectory() + "/Documents/ArrayBackUp.txt"
//        if let loadArray = NSArray(contentsOfFile: copyToThisPath) as? [String] {
//            print(loadArray)
//        }
//        let moveToThisPath = NSHomeDirectory() + "/Documents/saveArray.txt"
//        if let loadArray = NSArray(contentsOfFile: moveToThisPath) as? [String] {
//            print(loadArray)
//        }
        

    }
    
    func deleteFile() {
        // 1. 找出原來檔案路徑
        let path = NSHomeDirectory() + "/Documents/saveArrayAgain.txt"
        // 2. 用FileManager 來刪除檔案
        do {
            try FileManager.default.removeItem(atPath: path)
        } catch {
            
        }
    }
    
    func moveOrCopy() {
        // 1. 找出原來檔案路徑
        let path = NSTemporaryDirectory() + "saveArray.txt"
        
        // 2. 要拷貝檔案的路徑
        let copyToThisPath = NSHomeDirectory() + "/Documents/ArrayBackUp.txt"
        
        // 3. 要移動檔案的路徑
        let moveToThisPath = NSHomeDirectory() + "/Documents/saveArray.txt"
        
        // 4. 用FileManager 來移動或拷貝檔案
        // 5. 新增錯誤處理2016.10.12
        do {
            try FileManager.default.copyItem(atPath: path, toPath: copyToThisPath)
        } catch let error as NSError {
            print(error.localizedDescription)
            print("Can not copy file")
        }
        
        do {
            try FileManager.default.moveItem(atPath: path, toPath: moveToThisPath)
        } catch let error as NSError{
            print(error.localizedDescription)
            print("Can not move file")
        }
    }
    
    func checkOutIfItsFolder() {
        let path = NSTemporaryDirectory() + "/images"
        var isDirectory: ObjCBool = false
        let isExist = FileManager.default.fileExists(atPath: path, isDirectory: &isDirectory)
        if isExist == true && isDirectory.boolValue == true {
            print("該檔案存在，而且是資料夾")
        } else  if isExist == true && isDirectory.boolValue == false {
            print("該檔案存在，但不是資料夾")
        } else {
            print("該檔案不存在")
        }
    }
    
    func checkOutTmp() {
        // 1. 想要知道 Temp 裡面有什麼檔案
        let temPath = NSTemporaryDirectory()
        
        // 2. 用FileManager 找出有什麼檔案
        do {
            let fileList = try FileManager.default.contentsOfDirectory(atPath: temPath)
            for file in fileList {
                print(file)
            }
        } catch {
            print("Can not get content")
        }
    }
    
    func creatFolder() {
        // 1. 先確定要產生的路徑
        let directoryPath = NSTemporaryDirectory() + "/images"
        
        // 2. 用 FileManager 來產生資料夾
        do {
            try FileManager.default.createDirectory(atPath: directoryPath, withIntermediateDirectories: true, attributes: nil)
        } catch {
            print("Can not create folder")
        }
        
    }
    
    func loadImage() {
        // 1. 找出存檔路徑
        let filePath = NSTemporaryDirectory() + "saveImage.data"
        
        let myImage = UIImage(contentsOfFile: filePath)
        
        myImageView.image = myImage
    }
    
    func saveImage(image: UIImage) {
        // 1. UIImage 轉成 Data
        if let dataToSave = UIImageJPEGRepresentation(image, 1.0) {
            
            // 2. 找出存檔路徑
            let filePath = NSTemporaryDirectory() + "saveImage.data"
            
            // 3. 把路徑改成 URL
            let fileURL = URL(fileURLWithPath: filePath)
            
            // 3. 存檔
            do {
                try dataToSave.write(to: fileURL)
            } catch {
                print("Can not save image")
            }
        }
    }
    
    func loadDictionary() {
        // 1. 找到存檔路徑
        let filePath = NSTemporaryDirectory() + "saveDict.txt"
        
        // 2. 用 NSDictionary(contentsOfFile) 來 load 存檔的陣列
        if let loadedDict = NSDictionary(contentsOfFile: filePath) as? [String:String] {
            print(loadedDict)
        }
    }
    
    func saveDictionary() {
        // 1. 要存檔的Dictionary
        let originDict = ["red" : "apple", "yellow" : "banana", "green" : "mango"]
        
        // 2. 轉換成 NSDictionary 才能存檔
        let dictToSave = NSDictionary(dictionary: originDict)
        
        // 3. 找出存檔路徑
        let filePath = NSTemporaryDirectory() + "saveDict.txt"
        
        // 4. 存入
        dictToSave.write(toFile: filePath, atomically: true)
    }
    
    func loadArray() {
        // 1. 找到存檔路徑
        let filePath = NSTemporaryDirectory() + "saveArray.txt"
        
        // 2. 用 NSArray(contentsOfFile) 來 load 存檔的陣列
        if let loadedArray = NSArray(contentsOfFile: filePath) as? [String] {
            print(loadedArray)
        }
    }
    
    func saveArray(original: [String]) {
        // 1. 要存檔的陣列
        let originalArray = original
        
        // 2. 轉換成 NSArray 才能存檔
        let arrayToSave = NSArray(array: originalArray)
        
        // 3. 找出存檔路徑
        let filePath = NSTemporaryDirectory() + "saveArray.txt"
        
        // 4. 存入
        arrayToSave.write(toFile: filePath, atomically: true)
    }
    
    func loadString() {
        // 1. 找到存檔路徑
        let filePath = NSTemporaryDirectory() + "Text.txt"
        
        // 2. 用 NSString(contentsOfFile) 來 load 存檔的字串
        do {
            let loadedString = try NSString(contentsOfFile: filePath, encoding: String.Encoding.utf8.rawValue)
            print(loadedString)
        } catch {
            print("Can not load string")
        }
    }
    
    func saveString(_ thisString: String) {
        // 1. 儲存字串
        let text = thisString
        
        // 2. 找到存檔路徑
        let filePath = NSTemporaryDirectory() + "Text.txt"
        
        // 3. 真的存檔
        do {
            try text.write(toFile: filePath, atomically: true, encoding: .utf8)
        } catch {
            print("Not save correctly")
        }
    }
    
    func findDocumentsURL() {
        // 1. 找出 Documents 資料夾路徑
        let path = NSHomeDirectory() + "/Documents"
        
        // 2. 轉換成URL
        let documentsURL = URL(fileURLWithPath: path)
        
        // 3. 另外一種找到 Documents 資料夾URL的方法
        let anotherURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        // 4. 印出來
        print("path : \(path)")
        print("documentURL : \(documentsURL)")
        print("anotherURL : \(anotherURL)")
    }
    
    func findCaches() {
        // 1. 找出 Caches 資料夾路徑
        let path = NSHomeDirectory() + "/Library/Caches"
        
        // 2. 轉換成URL
        let cachesURL = URL(fileURLWithPath: path)
        
        // 3. 另外一種找到 Caches 資料夾URL的方法
        let anotherURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        
        // 4. 印出來
        print("path : \(path)")
        print("cachesURL : \(cachesURL)")
        print("anotherURL : \(anotherURL)")
    }

    func findTemp() {
        // 1. 找出 Tmp 資料夾路徑
        let path = NSHomeDirectory() + "/tmp"
        
        // 1-2. 另外一種找到 Tmp 路徑的方法
        let anotherWayToFindPath = NSTemporaryDirectory()
        
        // 2. 轉換成URL
        let tempURL = URL(fileURLWithPath: path)
        
        // 3. 印出來
        print("path : \(path)")
        print("anotherWayToFindPath : \(anotherWayToFindPath)")
        print("tempURL : \(tempURL)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

