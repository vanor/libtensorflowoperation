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
	a := BinaryOperationNode const: 2.
	b := BinaryOperationNode const: 3.
	c := a + b.
	
	self assert: (c outputs first) equals: 5.
]

{ #category : #tests }
OperationNodeTest >> testSimpleSigmoidOperation [
	"to test the Sigmoid TensorFlow Operation on a node."

	| a |
	a := (UnaryOperationNode const: 0) sigmoid.
	
	self assert: (a outputs first) equals: 0.5
]

{ #category : #tests }
OperationNodeTest >> testTreeAddOeration [
	"to test the ADD TensorFlow Operation on more than two nodes."

	| a b c d e |
	a := BinaryOperationNode const: 2.
	b := BinaryOperationNode const: 3.
	c := a + b.
	d := BinaryOperationNode const: 1.
	e := c + d.
	
	self assert: (e outputs first) equals: 6.
]
