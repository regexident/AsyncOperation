//
//  AsyncOperation.swift
//  AsyncOperation
//
//  Created by Vincent Esche on 4/7/15.
//  Copyright (c) 2015 Vincent Esche. All rights reserved.
//

import Foundation

open class AsyncOperation : Operation {

	public enum State : String {
		case Waiting = "isWaiting"
		case Ready = "isReady"
		case Executing = "isExecuting"
		case Finished = "isFinished"
		case Cancelled = "isCancelled"
	}

	open var state: State = State.Waiting {
		willSet {
			willChangeValue(forKey: State.Ready.rawValue)
			willChangeValue(forKey: State.Executing.rawValue)
			willChangeValue(forKey: State.Finished.rawValue)
			willChangeValue(forKey: State.Cancelled.rawValue)
		}
		didSet {
			didChangeValue(forKey: State.Cancelled.rawValue)
			didChangeValue(forKey: State.Finished.rawValue)
			didChangeValue(forKey: State.Executing.rawValue)
			didChangeValue(forKey: State.Ready.rawValue)
		}
	}

	open override var isReady: Bool {
		if self.state == .Waiting {
			return super.isReady
		} else {
			return self.state == .Ready
		}
	}

	open override var isExecuting: Bool {

		if self.state == .Waiting {
			return super.isExecuting
		} else {
			return self.state == .Executing
		}
	}

	open override var isFinished: Bool {

		if self.state == .Waiting {
			return super.isFinished
		} else {
			return self.state == .Finished
		}
	}

	open override var isCancelled: Bool {
		if self.state == .Waiting {
			return super.isCancelled
		} else {
			return self.state == .Cancelled
		}
	}

	open override var isAsynchronous: Bool {
		return true
	}

}

open class AsyncBlockOperation : AsyncOperation {

	public typealias Closure = (AsyncBlockOperation) -> ()

	let closure: Closure

	public init(closure: @escaping Closure) {
		self.closure = closure
	}

	open override func main() {
		self.closure(self)
	}

}
