//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  Provides supporting functions for setting up a live view.
//

import UIKit
import PlaygroundSupport

/// Instantiates a new instance of a live view.
///
/// By default, this loads an instance of `LiveViewController` from `LiveView.storyboard`.
public func instantiateLiveView(liveCode :Int) -> PlaygroundLiveViewable {
    
    switch liveCode {
    case 1: return VCHello()
    case 2: return VCPoint()
    case 3: return VCSwap()
    default: return VCSort()
    }


}

