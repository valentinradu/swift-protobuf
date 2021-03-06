// Sources/PluginLibrary/ProvidesSourceCodeLocation.swift - SourceCodeInfo.Location provider
//
// Copyright (c) 2014 - 2017 Apple Inc. and the project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.txt for license information:
// https://github.com/apple/swift-protobuf/blob/master/LICENSE.txt
//
// -----------------------------------------------------------------------------

import Foundation

public protocol ProvidesSourceCodeLocation {
  var sourceCodeInfoLocation: Google_Protobuf_SourceCodeInfo.Location? { get }
}

// Default implementation for things that support ProvidesLocationPath.
extension ProvidesSourceCodeLocation where Self: ProvidesLocationPath {
  public var sourceCodeInfoLocation: Google_Protobuf_SourceCodeInfo.Location? {
    var path = [Int32]()
    getLocationPath(path: &path)
    return file.sourceCodeInfoLocation(path: path)
  }
}

// Helper to get source comments out of ProvidesSourceCodeLocation
extension ProvidesSourceCodeLocation {
  public func protoSourceComments(commentPrefix: String = "///",
                                  leadingDetachedPrefix: String? = nil) -> String {
    if let loc = sourceCodeInfoLocation {
      return loc.asSourceComment(commentPrefix: commentPrefix,
                                 leadingDetachedPrefix: leadingDetachedPrefix)
    }
    return String()
  }
}
