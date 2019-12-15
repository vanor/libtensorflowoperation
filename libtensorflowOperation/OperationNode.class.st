"
This class represent a higher node of a TF Operation.

This class create a new operation and help to create an operation from other created operation nodes.

This code is an implementation of an idea on my memory. 

Public API and Key Messages

- initialize
"
Class {
	#name : #OperationNode,
	#superclass : #Object,
	#instVars : [
		'inputsNodes',
		'outputs',
		'type',
		'engine'
	],
	#category : #libtensorflowOperation
}

{ #category : #'root operations' }
OperationNode class >> const: aValue [
	"to build a const operation node with a value."

	^ self new type: 'Const';
					outputs: { aValue }
]

{ #category : #visiting }
OperationNode >> addEngine: anEngine [
	"To register a class which will doing computation."

	engine := anEngine.
	engine compute: self
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
OperationNode >> outputs [
	"to get outputs attribute."

	^ outputs
]

{ #category : #accessing }
OperationNode >> outputs: anArray [
	"to set outputs attribute."

	outputs := anArray
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
