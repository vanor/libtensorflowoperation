"
This class represent a visitor of Pharo AST for simulate eager mode.

This class take a block and do a deep first search algorith.

This work is for my master thesis. 

Public API and Key Messages

- message one   
- message two
"
Class {
	#name : #TFGenerateEagerVisitor,
	#superclass : #RBProgramNodeVisitor,
	#instVars : [
		'code',
		'tree'
	],
	#category : #libtensorflowOperation
}

{ #category : #accessing }
TFGenerateEagerVisitor >> code [
	"To get attribute code of the current visitor."

	^ code
]

{ #category : #execution }
TFGenerateEagerVisitor >> execute [
	"To execute the generated code."

	^ Smalltalk compiler evaluate: code contents
]

{ #category : #initialization }
TFGenerateEagerVisitor >> initialize [
	"To set up the stream."

	code := WriteStream on: (String new: 100)
]

{ #category : #visiting }
TFGenerateEagerVisitor >> visitAssignmentNode: anAssignmentNode [
	"To test."

	self visitNode: anAssignmentNode variable.
	code nextPutAll: ':='.
	self visitNode: anAssignmentNode value.
]

{ #category : #visiting }
TFGenerateEagerVisitor >> visitLiteralArrayNode: aRBLiteralArrayNode [ 
	"To visit a literal array node."
	
	(aRBLiteralArrayNode parent class = RBAssignmentNode) ifTrue: [ 
			code nextPutAll: '(BinaryOperationNode const:';
		  		  nextPutAll: aRBLiteralArrayNode value asString;
		  		  nextPut: $) ].
	
	aRBLiteralArrayNode contents do: [:each | self visitNode: each]
]

{ #category : #visiting }
TFGenerateEagerVisitor >> visitLiteralNode: aLiteralNode [
	"To test."

	(aLiteralNode parent class = RBAssignmentNode) ifTrue: [ 
			code nextPutAll: '(OperationNode const:';
		  		  nextPutAll: aLiteralNode value asString;
		  		  nextPut: $) ]
]

{ #category : #visiting }
TFGenerateEagerVisitor >> visitMessageNode: aMessageNode [
	"To do the computation with TensorFlow."
		
	self visitNode: aMessageNode receiver.
	code nextPutAll: aMessageNode selector.
	aMessageNode arguments ifNotEmpty: [ self visitNode: aMessageNode arguments first ]
]

{ #category : #visiting }
TFGenerateEagerVisitor >> visitSequenceNode: aSequenceNode [
	"To test."

	aSequenceNode statements
		do: [ :each | self visitNode: each ]
		separatedBy: [ code nextPutAll: '. '. ]
]

{ #category : #visiting }
TFGenerateEagerVisitor >> visitVariableNode: aVariableNode [
	"To test."

	code nextPutAll: aVariableNode name.
	code nextPutAll: ' '
]
