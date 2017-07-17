# AsyncOperation

**AsyncOperation** aims to ease the pain commonly encountered when having to subclass NSOperation for async tasks.

## Example usage

Let's assume you have a time-consuming task that you'd rather perform on a background-thread.  
**AsyncOperation** provides you with two options for wrapping said task in an asynchronous `NSOperation`:

### Using `AsyncOperation`:

```swift
class ExampleOperation : AsyncOperation {
  override func main() {
    self.state = .Executing

    DispatchQueue.main.async {
      // perform time-consuming task
      self.state = .Finished
    }
  }
}
```

### Using `AsyncBlockOperation`:

```swift
AsyncBlockOperation() { operation in
  operation.state = .Executing
  DispatchQueue.main.async {
    // perform time-consuming task
    operation.state = .Finished
  }
}
```

## Demos

**AsyncOperation** contains a demo app.

## Installation

Just copy the files in `"AsyncOperation/Classes/..."` into your project.

Alternatively you can install **AsyncOperation** into your project with [Carthage][1] (`github 'regexident/AsyncOperation'`) or with [CocoaPods][2] (`pod 'AsyncOperation'`)

## Swift

**AsyncOperation** is implemented in 100% Swift 3.

## Dependencies

None.

## Requirements.

OS X 10.9+ / iOS 8.0+

## Creator

Vincent Esche ([@regexident][3])

## License

**Sandbox** is available under a **modified BSD-3 clause license** with the **additional requirement of attribution**. See the `LICENSE` file for more info.

[1]:	https://github.com/Carthage/Carthage
[2]:	http://cocoapods.org/
[3]:	http://twitter.com/regexident
