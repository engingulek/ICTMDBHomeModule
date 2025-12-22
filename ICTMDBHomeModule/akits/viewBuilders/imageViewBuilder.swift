//
//  imageViewBuilder.swift
//  ICTMDBHomeModule
//
//  Created by Engin Gülek on 22.12.2025.
//

import SwiftUI
import Foundation
import Kingfisher


public enum ImageSize {
    case big
    case mid
    case min
    
    var image : (width:CGFloat,height:CGFloat){
        switch self {
        case .big:
            (50,50)
        case .mid:
            (30,30)
        case .min:
            (15,15)
        }
    }
}


@MainActor @ViewBuilder
public func kfImageView(for size:ImageSize,url:String) -> some View {
    KFImage.url(URL(string: url))
        
        .fade(duration: 0.25)
        .cacheMemoryOnly()
        .resizable()
        .scaledToFit()
      
        .frame(width: size.image.width,height: size.image.height)
      
        .clipShape(.circle)
            //  .placeholder(placeholderImage)
           //   .setProcessor(processor)
            /*  .loadDiskFileSynchronously()
              .cacheMemoryOnly()
              .fade(duration: 0.25)
            //  .lowDataModeSource(.network(lowResolutionURL))
              .onProgress { receivedSize, totalSize in  }
              .onSuccess { result in  }
              .onFailure { error in }*/
}


@ViewBuilder
public func systemImageView(for size:ImageSize,systemImage:String,color:Color) -> some View {
    Image(systemName: systemImage)
        .scaledToFit()
        .frame(width: size.image.width,height: size.image.height)
        .foregroundStyle(color)
        .clipShape(.circle)
}


@ViewBuilder
public func resourceImageView(for size:ImageSize,image:  SwiftUI.ImageResource,color:Color) -> some View {
    Image(image)
        .scaledToFit()
        .frame(width: size.image.width,height: size.image.height)
        .foregroundStyle(color)
        .clipShape(.circle)
}
