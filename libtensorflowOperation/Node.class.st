"
This class is an abstract class of operation node for the implementation of Visitor Design Pattern.

This class only declare an accept visitor method which should be implemented in subclasses.

In respect of the GoF specs. 

Public API and Key Messages

- message one
"
Class {
	#name : #Node,
	#superclass : #Object,
	#category : #libtensorflowOperation
}

{ #category : #visiting }
Node >> accept: aVisitor [
	"To accept a visitor of one operation node."

	self shouldBeImplemented
]
