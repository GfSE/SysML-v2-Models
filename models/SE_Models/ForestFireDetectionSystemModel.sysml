package ForestFireDetectionSystemModel {   
    
    // Import the SYSMOD language extensions
    import SYSMOD::*;

    package FFDS_Core {
        doc /* The Core package contains elements 
            * that are valid for all system configurations
            */
        #system ffds {
            attribute redefines problemStatement = "How can we  [...]";
            attribute redefines systemIdea = "The FFDS is a  [...]";
        }
     }
 
    package FFDS_Objectives {
        #systemObjective <'OBJ-B1'> 'Market Leader' {
            doc /* The system will make the vendor the market 
                 * leader for forest fire detection systems.
                 */
        }
        #systemObjective <'OBJ-S1'> 'Reliable Detection' {
             doc /* Any forest fire is detected by the system on time 
                  * to start effective counteractions.
                  */
        }
        #systemObjective <'OBJ-S2'> 'Affordability' {
              doc /* The system is affordable for any forest authority. */
        }                               
    }
    
    package FFDS_Variants;
    package FFDS_Configurations {
        package FFDS_StandardEdition {
            #system ffdsStandardEdition :> FFDS_Core::ffds;
        }
    }
}