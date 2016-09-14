actions
commitWithMessage: message
	| changedPackages savedVersions newCommit |

	changedPackages := self loadedPackages select: [ :package | package workingCopy needsSaving ].
	savedVersions := changedPackages collect: [ :package | 
		self internalSavePackage: package withMessage: message  ].
	
	newCommit := self backend 
		commit: savedVersions 
		withMessage: message.
		
	self loadedCode commited: newCommit changingPackages: changedPackages.