"
This class represent a higher node of a TF Operation.

This class create a new operation and help to create an operation from other created operation nodes.

This code is an implementation of an idea on my memory. 

Public API and Key Messages

- initialize
"
Class {
	#name : #OperationNode,
	#superclass : #Node,
	#instVars : [
		'inputsNodes',
		'inputs',
		'output',
		'type',
		'visitor'
	],
	#category : #libtensorflowOperation
}

{ #category : #'root operations' }
OperationNode class >> const: aValue [
	"to build a const operation node with a value."

	^ self new type: 'Const';
					output: aValue
]

{ #category : #arithmetic }
OperationNode >> + anOperationNode [
	"to simulate the eager mode on addition TensorFlow Operation."

	| result |
	result := OperationNode new type: 'Add'.
	result inputsNodes: { self . anOperationNode }.
	result accept: (AddVisitor new).
	^ result
]

{ #category : #visiting }
OperationNode >> accept: aVisitor [
	"To add a visitor on current node."

	visitor := aVisitor.
	visitor visit: self
]

{ #category : #accessing }
OperationNode >> inputs [
	"To get inputs attribute."

	^ inputs
]

{ #category : #accessing }
OperationNode >> inputs: arrayValues [
	"To set inputs attribute."

	inputs := arrayValues
]

{ #category : #accessing }
OperationNode >> inputsNodes [
	"to get inputsNodes attribute."

	^ inputsNodes
]

{ #category : #accessing }
OperationNode >> inputsNodes: anArray [
	"to set inputsNodes attribute."

	inputsNodes := anArray
]

{ #category : #accessing }
OperationNode >> output [
	"to get output attribute."

	^ output
]

{ #category : #accessing }
OperationNode >> output: aValue [
	"to set output attribute."

	output := aValue
]

{ #category : #accessing }
OperationNode >> type [
	"to get type attribute."

	^ type
]

{ #category : #accessing }
OperationNode >> type: aString [
	"to set type attribute."

	type := aString
]
