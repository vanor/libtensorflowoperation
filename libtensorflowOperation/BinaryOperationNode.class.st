"
This class represent a higher node of a TF binary operation.

This class create a new operation and help to create an operation from other created operation nodes.

This code is an implementation of an idea on my memory. 

Public API and Key Messages

- initialize
"
Class {
	#name : #BinaryOperationNode,
	#superclass : #OperationNode,
	#category : #libtensorflowOperation
}

{ #category : #arithmetic }
BinaryOperationNode >> * anOperationNode [
	"To simulate the eager mode on matmul TensorFlow Operation."

	| result |
	result := BinaryOperationNode new type: 'MatMul'.
	result inputsNodes: { self . anOperationNode }.
	result addEngine: (OperationEngine new).
	^ result
]

{ #category : #arithmetic }
BinaryOperationNode >> + anOperationNode [
	"To simulate the eager mode on addition TensorFlow Operation."

	| result |
	result := BinaryOperationNode new type: 'Add'.
	result inputsNodes: { self . anOperationNode }.
	result addEngine: (OperationEngine new).
	^ result
]
