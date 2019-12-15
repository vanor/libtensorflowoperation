"
This class represent a higher node of a TF unary operation.

This class create a new operation and help to create an operation from other created operation nodes.

This code is an implementation of an idea on my memory. 

Public API and Key Messages

- initialize
"
Class {
	#name : #UnaryOperationNode,
	#superclass : #OperationNode,
	#category : #libtensorflowOperation
}

{ #category : #'ops unary' }
UnaryOperationNode >> sigmoid [
	"To simulate the eager mode on sigmoid TensorFlow Operation."
			
	| result |
	result := UnaryOperationNode new type: 'Sigmoid'.
	result inputsNodes: { self }.
	result addEngine: (OperationEngine new).
	^ result
]
