"
This class represent all computations done by TF.

In this class i do add Operations, matmul and many others.

This work is done for my master thesis. 

Public API and Key Messages

- message one   
- message two
"
Class {
	#name : #OperationEngine,
	#superclass : #Object,
	#category : #libtensorflowOperation
}

{ #category : #adding }
OperationEngine >> addComputation: aParentOperationNode [
	"This method take children and do a sum of them."

	| graph nodes result session r inputsNodes inputs value |
	graph := TF_Graph create.
	inputsNodes := aParentOperationNode inputsNodes.
	nodes := inputsNodes collectWithIndex: [ :node :index |
		graph placeholder: ('node_', index asString) type: TF_Tensor typeFloat ].
	inputs := inputsNodes collect: #output.
	graph fromBlock: [ r := (nodes first) + (nodes second) ].
	session := TF_Session on: graph.
	graph initializeOn: session.
	result := session
						runInputs: (nodes collect: [ :node | node input: 0 ])
						values: (inputs collect: #asFloatTensor)
						outputs: {r output: 0}.
	value := (result collect: #asNumbers) first.
	aParentOperationNode output: value
]

{ #category : #initialize }
OperationEngine >> compute: aNode [
	"This message is a generic message."

	aNode type = 'Add'
		ifTrue: [ self addComputation: aNode ].
	aNode type = 'MatMul'
		ifTrue: [ self matMulComputation: aNode ].
]

{ #category : #adding }
OperationEngine >> matMulComputation: aParentOperationNode [
	"This method take children and do a matmul of them."

	| graph nodes result session r inputsNodes inputs values |
	graph := TF_Graph create.
	inputsNodes := aParentOperationNode inputsNodes.
	nodes := inputsNodes collectWithIndex: [ :node :index |
		graph placeholder: ('node_', index asString) type: TF_Tensor typeFloat ].
	inputs := inputsNodes collect: #output.
	graph fromBlock: [ r := (nodes first) * (nodes second) ].
	session := TF_Session on: graph.
	graph initializeOn: session.
	result := session
						runInputs: (nodes collect: [ :node | node input: 0 ])
						values: (inputs collect: #asFloatTensor)
						outputs: {r output: 0}.
	values := result collect: #asNumbers.
	aParentOperationNode output: values
]