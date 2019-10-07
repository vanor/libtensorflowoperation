"
An OperationNodeTest is a test class for testing the behavior of OperationNode
"
Class {
	#name : #OperationNodeTest,
	#superclass : #TestCase,
	#category : #'libtensorflowOperation-Tests'
}

{ #category : #tests }
OperationNodeTest >> testSimpleAddOeration [
	"to test the ADD TensorFlow Operation on two nodes."

	| a b c |
	a := OperationNode const: 2.
	b := OperationNode const: 3.
	c := a + b.
	
	self assert: (c output) equals: 5.
]

{ #category : #tests }
OperationNodeTest >> testTreeAddOeration [
	"to test the ADD TensorFlow Operation on more than two nodes."

	| a b c d e |
	a := OperationNode const: 2.
	b := OperationNode const: 3.
	c := a + b.
	d := OperationNode const: 1.
	e := c + d.
	
	self assert: (e output) equals: 6.
]
