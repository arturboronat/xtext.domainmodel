package org.example.domainmodel.tests

import com.google.inject.Inject
import org.eclipse.xtext.junit4.InjectWith
//import org.eclipse.xtext.junit4.TemporaryFolder
import org.eclipse.xtext.junit4.XtextRunner
import org.eclipse.xtext.xbase.compiler.CompilationTestHelper
//import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith

@RunWith(XtextRunner)
@InjectWith(DomainmodelInjectorProvider)
class DomainmodelCompilingTest {

//	@Rule
//	@Inject public TemporaryFolder temporaryFolder
	
	@Inject extension CompilationTestHelper
		
	@Test def void testCompile() {		
		'''
		datatype String 
		
		entity HasAuthor {
			author: String
		}
		'''.assertCompilesTo(
		'''
		
		public class HasAuthor {
		    private String author;
		    
		    public String getAuthor() {
		        return author;
		    }
		    
		    public void setAuthor(String author) {
		        this.author = author;
		    }
		}
		'''
		)

	}
}