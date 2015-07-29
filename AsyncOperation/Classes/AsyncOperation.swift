//
//  AsyncOperation.swift
//  AsyncOperation
//
//  Created by Vincent Esche on 4/7/15.
//  Copyright (c) 2015 Vincent Esche. All rights reserved.
//

import Foundation

public class AsyncOperation : NSOperation {
	
	public enum State : String {
		case Waiting = "isWaiting"
		case Ready = "isReady"
		case Executing = "isExecuting"
		case Finished = "isFinished"
		case Cancelled = "isCancelled"
	}
	
	public var state: State = State.Waiting {
		willSet {
			willChangeValueForKey(State.Ready.rawValue)
			willChangeValueForKey(State.Executing.rawValue)
			willChangeValueForKey(State.Finished.rawValue)
			willChangeValueForKey(State.Cancelled.rawValue)
		}
		didSet {
			didChangeValueForKey(State.Cancelled.rawValue)
			didChangeValueForKey(State.Finished.rawValue)
			didChangeValueForKey(State.Executing.rawValue)
			didChangeValueForKey(State.Ready.rawValue)
		}
	}
	
	public override var ready: Bool {
		if self.state == .Waiting {
			return super.ready
		} else {
			return self.state == .Ready
		}
	}
	
	public override var executing: Bool {
		return self.state == .Executing
	}
	
	public override var finished: Bool {
		return self.state == .Finished
	}
	
	public override var cancelled: Bool {
		return self.state == .Cancelled
	}
	
	public override var asynchronous: Bool {
		return true
	}
	
}

public class AsyncBlockOperation : AsyncOperation {
	
	public typealias Closure = (AsyncBlockOperation) -> ()
	
	let closure: Closure
	
	public init(closure: Closure) {
		self.closure = closure
	}
	
	public override func main() {
		self.closure(self)
	}
	
}