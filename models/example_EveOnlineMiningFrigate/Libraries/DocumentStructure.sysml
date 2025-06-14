library package DocumentStructureLibrary {
    private import ScalarValues::*;

    // A Document is a top-level semantic container
    abstract part def Document {
        attribute title : String;
        attribute status : String;
        part :>> chapters[*];
    }

    // Chapters define hierarchical sections
    abstract part def Chapter {
        attribute title : String;
        part :>> sections[*];
    }

    // Sections provide the narrative or model references
    abstract part def Section {
        attribute heading : String;
        attribute content : String;
    }
    abstract part documents : Document[*] nonunique;
    abstract part chapters : Chapter[*] nonunique;
    abstract part sections : Section[*] nonunique;

}
library package DocumentStructureMetadata {
    private import DocumentStructureLibrary::*;
    private import Metaobjects::SemanticMetadata; 

    metadata def document :> SemanticMetadata {
        :>> baseType = documents meta SysML::Usage; 
    }
    metadata def chapter :> SemanticMetadata {
        :>> baseType = chapters meta SysML::Usage; 
    }
    metadata def section :> SemanticMetadata {
        :>> baseType = sections meta SysML::Usage; 
    }
}