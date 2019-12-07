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

{ #category : #adding }
TFGenerateEagerVisitor >> addComputation: aMessageNode [
	"To do add operation with TensorFlow and return the output."

	| graph nodes result session r inputs |
	graph := TF_Graph create.
	inputs := { aMessageNode receiver . aMessageNode arguments first }.
	nodes := inputs collectWithIndex: [ :node :index |
		graph placeholder: ('node_', index asString) type: TF_Tensor typeFloat ].
	graph fromBlock: [ r := (nodes first) + (nodes second) ].
	session := TF_Session on: graph.
	graph initializeOn: session.
	result := session
						runInputs: (nodes collect: [ :node | node input: 0 ])
						values: (inputs collect: #asFloatTensor)
						outputs: {r output: 0}.
	^ (result collect: #asNumbers) first.
]

{ #category : #accessing }
TFGenerateEagerVisitor >> code [
	"To get attribute code of the current visitor."

	^ code
]

{ #category : #'as yet unclassified' }
TFGenerateEagerVisitor >> executeTree [
	"To execute the tree generated and get the output."

	| outputNode |
	outputNode := ProtoObject executeMethod: (tree asDoit compiledMethod).
	^ outputNode output
]

{ #category : #'as yet unclassified' }
TFGenerateEagerVisitor >> generateTree [
	"To generate the corresponding tree from source code generated."

	tree := RBParser parseExpression: code contents
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
			code nextPutAll: '(OperationNode const:';
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
	self visitNode: aMessageNode arguments first
]

{ #category : #visiting }
TFGenerateEagerVisitor >> visitSequenceNode: aSequenceNode [
	"To test."

	aSequenceNode statements
		do: [ :each | self visitNode: each ]
		separatedBy: [ code nextPut: $.. ]
]

{ #category : #visiting }
TFGenerateEagerVisitor >> visitVariableNode: aVariableNode [
	"To test."

	code nextPutAll: aVariableNode name
]
