//
//  ViewController.swift
//  AsyncOperationDemo
//
//  Created by Vincent Esche on 4/7/15.
//  Copyright (c) 2015 Vincent Esche. All rights reserved.
//

import UIKit

import AsyncOperation

class DelayOperation : AsyncOperation {
	
	let delay: TimeInterval
	
	init(delay: TimeInterval) {
		self.delay = delay
	}
	
	override func main() {
		self.state = .Executing
		let delayTime = DispatchTime.now() + Double(Int64(self.delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
		DispatchQueue.main.asyncAfter(deadline: delayTime) {
			self.state = .Finished
		}
	}
	
}

class ViewController: UIViewController {

	@IBOutlet var progressView: UIProgressView!
	@IBOutlet var button: UIButton!
	
	let queue: OperationQueue = OperationQueue()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	@IBAction func startOperations(_ sender: UIButton?) {
		self.progressView.progress = 0.0
		self.button.isEnabled = false
		
		let finalOperation = BlockOperation() {
			DispatchQueue.main.async {
				self.button.isEnabled = true
			}
		}
		
		let count = 10
		
		for i in 1...count {
			
			let delay = (TimeInterval(i) / TimeInterval(count))
			
			let operation: AsyncOperation!
			
			if i % 2 == 0 {
				operation = AsyncBlockOperation() { operation in
					operation.state = .Executing

                    let delayTime = DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
                    DispatchQueue.main.asyncAfter(deadline: delayTime) {
                        operation.state = .Finished
                    }
				}
			} else {
				operation = DelayOperation(delay: delay)
			}
		
			operation.completionBlock = {
				DispatchQueue.main.async {
					let progress = Float(i) / Float(count)
					print("progress: \(progress)")
					self.progressView.progress = Float(i) / Float(count)
				}
			}
			
			finalOperation.addDependency(operation)
			
			self.queue.addOperation(operation)
		}
		
		self.queue.addOperation(finalOperation)
	}
}

