package Metamodel {
    
    import ScalarValues::String;
    
    part def ModelElement {
        attribute muid : String;
        attribute name : String;
        attribute description : String;
    }
    
}

package BaseFormat {
    
    import ScalarValues::String;
    import ScalarValues::Real;

    part def Format {
        attribute id : Real;
        attribute name : String;
        attribute table : String;
    }
}

package Datatypes {
    
    import Metamodel::ModelElement;
    import BaseFormat::Format;
    
    part def Datatype specializes ModelElement {
        part base_format[1] : Format;
    }
    
    part def AutoReference specializes Datatype {
        attribute prefix : ScalarValues::String;
        attribute start_from : ScalarValues::Boolean;
        attribute interval : ScalarValues::Boolean;
    }
    
    part def Integer specializes Datatype {
        attribute minimum_value : ScalarValues::Real;
        attribute maximum_value : ScalarValues::Real;
        attribute has_display_separator : ScalarValues::Boolean;
        attribute has_edit_separator : ScalarValues::Boolean;
        
        assert constraint { base_format.id == 1 }
    }
    
    part Boolean : Datatype { 
        assert constraint { base_format.id == 3 }
    }
}

package poc {
    
    part test {
        part id : Datatypes::AutoReference;
        part quantity : Datatypes::Integer;
    }
}