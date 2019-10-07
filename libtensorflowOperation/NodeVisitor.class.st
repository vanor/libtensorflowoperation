"
This class is for implement a design pattern visitor on a tree of OperationNode.

This class is only declaration of methods which the visitor will perform.

In accordance to the GoF specs. 

Public API and Key Messages

- message one
"
Class {
	#name : #NodeVisitor,
	#superclass : #Object,
	#category : #libtensorflowOperation
}

{ #category : #visiting }
NodeVisitor >> visit: anOperationNode [
	"To do the visit procedure on one operation node."

	self shouldBeImplemented
]
