//
//  MockHomeViewController.swift
//  ICTMDBHomeModule
//
//  Created by Engin Gülek on 12.11.2025.
//

import Foundation
import UIKit
@testable import ICTMDBHomeModule

final class MockHomeViewController: PresenterToViewHomeProtocol {
    
  
    // MARK: - Mock Functions

    var invokedRelaodCollectionView = false
    var invokedRelaodCollectionViewCount = 0
    func relaodCollectionView() {
        invokedRelaodCollectionView = true
        invokedRelaodCollectionViewCount += 1
    }
    
    var invokedSetNavigationTitle = false
    var invokedSetNavigationTitleCount = 0
    var invokedSetNavigationTitleData: [(title: String,())] = []
    func setNavigationTitle(title: String) {
         invokedSetNavigationTitle = true
         invokedSetNavigationTitleCount += 1
        invokedSetNavigationTitleData.append((title: title, ()))

    }
    

    var invokedSendError = false
    var invokedSendErrorCount = 0
    var invokedSendErrorData: [(isHidden: Bool, message: String)] = []
    func sendError(errorState: (isHidden: Bool, message: String)) {
        invokedSendError = true
        invokedSendErrorCount += 1
        invokedSendErrorData.append(errorState)
    }

    var invokedStartLoading = false
    var invokedStartLoadingCount = 0
    func startLoading() {
        invokedStartLoading = true
        invokedStartLoadingCount += 1
    }

    var invokedFinishLoading = false
    var invokedFinishLoadingCount = 0
    func finishLoading() {
        invokedFinishLoading = true
        invokedFinishLoadingCount += 1
    }

    var invokedSetBackColorAble = false
    var invokedSetBackColorAbleCount = 0
    var invokedSetBackColorAbleData: [String] = []
    func setBackColorAble(color: String) {
        invokedSetBackColorAble = true
        invokedSetBackColorAbleCount += 1
        invokedSetBackColorAbleData.append(color)
    }

    var invokedPushViewControllerAble = false
    var invokedPushViewControllerAbleCount = 0
    func pushViewControllerAble(_ vc: UIViewController, animated: Bool) {
        invokedPushViewControllerAble = true
        invokedPushViewControllerAbleCount += 1
    }

    
    
}
