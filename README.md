# WeakableSelf

![platforms](https://img.shields.io/badge/platforms-iOS%20%7C%20macOS%20%7C%20tvOS%20%7C%20watchOS-333333.svg)
![pod](https://img.shields.io/cocoapods/v/WeakableSelf.svg)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

## Context

Closures are one of Swift must-have features, and Swift developers are aware of how tricky they can be when they capture the reference of an external object, especially when this object is `self`.

To deal with this issue, developers are required to write additional code, using constructs such as `[weak self]` and `guard`, and the result looks like the following:

```swift
service.call(completion: { [weak self] result in
    guard let self = self else { return }
    
    // use weak non-optional `self` to handle `result`
})
```

## Purpose of `WeakableSelf`

The purpose of this micro-framework is to provide the developer with a helper function `weakify` that will allow him to declaratively indicate that he wishes to use a weak non-optional reference to `self` in closure, and not worry about how this reference is provided.

## Usage

Using this `weakify` function, the code above will be transformed into the much more concise:

```swift
import WeakableSelf

service.call(completion: weakify { strongSelf, result in    
    // use weak non-optional `strongSelf` to handle `result`
})
```

`weakify` works with closures that take up to 7 arguments.

## Installation

### Requirements

* Swift 4.2+
* Xcode 10+

### CocoaPods

Add the following to your `Podfile`:

`pod "WeakableSelf"`

### Carthage

Add the following to your `Cartfile`:

`github "vincent-pradeilles/weakable-self"`
