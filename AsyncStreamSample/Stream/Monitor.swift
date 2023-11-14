//
//  Monitor.swift
//  AsyncStreamSample
//
//  Created by 江本 光晴 on 2023/11/07.
//

import Foundation

class Monitor2 {
    // https://developer.apple.com/documentation/swift/asyncstream/makestream(of:bufferingpolicy:)
    // https://github.com/apple/swift-evolution/blob/main/proposals/0388-async-stream-factory.md
    let (stream, continuation) = AsyncStream.makeStream(of: String.self)
    
    var task: Task<Void, Never>? = nil
    
    deinit{
        stop()
    }
    
    func put(_ value: String){
        continuation.yield(value)
    }
    
    func start() {
        task = Task {
            for await value in stream {
                print("Monitor2 stream: \(value)")
            }
        }
    }
    
    func stop(){
        continuation.finish()
        task?.cancel()
    }

}

class Monitor {
    
    var task: Task<Void, Never>? = nil
    var handler: ((String) -> Void)?
    
    var stream: AsyncStream<String> {
        AsyncStream { [weak self] continuation in
            self?.handler = { actionType in
                continuation.yield(actionType)
            }
            continuation.onTermination = { @Sendable [weak self] _ in
                self?.terminate()
            }
        }
    }
    
    deinit{
        stop()
    }
    
    func put(_ value: String){
        self.handler?(value)
    }
    
    func terminate(){
        print("Monitor#terminate")
    }
    
    func start() {
        task = Task {
            for await value in stream {
                print("Monitor1 stream: \(value)")
            }
        }
    }
    
    func stop(){
        task?.cancel()
    }
    
}

