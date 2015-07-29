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
	
	let delay: NSTimeInterval
	
	init(delay: NSTimeInterval) {
		self.delay = delay
	}
	
	override func main() {
		self.state = .Executing
		let delayTime = dispatch_time(DISPATCH_TIME_NOW,
			Int64(self.delay * Double(NSEC_PER_SEC)))
		dispatch_after(delayTime, dispatch_get_main_queue()) {
			self.state = .Finished
		}
	}
	
}

class ViewController: UIViewController {

	@IBOutlet var progressView: UIProgressView!
	@IBOutlet var button: UIButton!
	
	let queue: NSOperationQueue = NSOperationQueue()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	@IBAction func startOperations(sender: UIButton?) {
		self.progressView.progress = 0.0
		self.button.enabled = false
		
		let finalOperation = NSBlockOperation() {
			dispatch_async(dispatch_get_main_queue()) {
				self.button.enabled = true
			}
		}
		
		let count = 10
		
		for i in 1...count {
			
			let delay = NSTimeInterval(i) / NSTimeInterval(count)
			
			let operation: AsyncOperation!
			
			if i % 2 == 0 {
				operation = AsyncBlockOperation() { operation in
					operation.state = .Executing
					let delayTime = dispatch_time(DISPATCH_TIME_NOW,
						Int64(delay * Double(NSEC_PER_SEC)))
					dispatch_after(delayTime, dispatch_get_main_queue()) {
						operation.state = .Finished
					}
				}
			} else {
				operation = DelayOperation(delay: delay)
			}
		
			operation.completionBlock = {
				dispatch_async(dispatch_get_main_queue()) {
					let progress = Float(i) / Float(count)
					println("progress: \(progress)")
					self.progressView.progress = Float(i) / Float(count)
				}
			}
			
			finalOperation.addDependency(operation)
			
			self.queue.addOperation(operation)
		}
		
		self.queue.addOperation(finalOperation)
	}
}

