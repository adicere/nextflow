process HELLO {

		[ directives ]

        input:
        val name
        

        output:
        stdout result
	    
	    // when:
	    // <condition>

        """
        echo 'Hello, $name!'
        """
}
