package org.example.domainmodel.generator

import com.google.inject.Inject
import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.generator.IGenerator2
import org.eclipse.xtext.naming.IQualifiedNameProvider
import org.example.domainmodel.domainmodel.Entity
import org.example.domainmodel.domainmodel.Feature
import org.eclipse.xtext.generator.IFileSystemAccess2
import org.eclipse.xtext.generator.IGeneratorContext

class DomainmodelGenerator implements IGenerator2 {
 
    @Inject extension IQualifiedNameProvider
 
    def compile(Entity e) ''' 
        «IF e.eContainer.fullyQualifiedName != null»
            package «e.eContainer.fullyQualifiedName»;
        «ENDIF»
        
        public class «e.name» «IF e.superType != null
                »extends «e.superType.fullyQualifiedName» «ENDIF»{
            «FOR f : e.features»
                «f.compile»
            «ENDFOR»
        }
    '''
 
    def compile(Feature f) '''
        private «f.type.fullyQualifiedName» «f.name»;
        
        public «f.type.fullyQualifiedName» get«f.name.toFirstUpper»() {
            return «f.name»;
        }
        
        public void set«f.name.toFirstUpper»(«f.type.fullyQualifiedName» «f.name») {
            this.«f.name» = «f.name»;
        }
    '''
				
	override afterGenerate(Resource input, IFileSystemAccess2 fsa, IGeneratorContext context) {
//		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override beforeGenerate(Resource input, IFileSystemAccess2 fsa, IGeneratorContext context) {
//		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override doGenerate(Resource input, IFileSystemAccess2 fsa, IGeneratorContext context) {
		for (e : input.allContents.toIterable.filter(Entity)) {
            fsa.generateFile(
                e.fullyQualifiedName.toString("/") + ".java",
                e.compile)
        }
	}
				
}