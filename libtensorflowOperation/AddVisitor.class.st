"
This class is for do a visit on Add nodes.

This class allow to compute sum of two child nodes.

This is for my Master Thesis. 

Public API and Key Messages

- message one
"
Class {
	#name : #AddVisitor,
	#superclass : #NodeVisitor,
	#category : #libtensorflowOperation
}

{ #category : #visiting }
AddVisitor >> visit: aParentOperationNode [
	"To do a visit on a node. This method take children and do a sum of them."

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
