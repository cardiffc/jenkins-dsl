job('Generated job - 2') {

	description('First job descripted')
	parameters {
		stringParam('Planet', defaultValue='World', description = 'This is World')
		choiceParam('OPTION', ['option 1 (default)', 'option 2', 'option 3'])
		booleanParam('BOOLEAN', true) 
	}	
}
