# Use Cases
## Prompts
- Describe a few use cases for the mining frigate
- Reconsider the use cases listed before as software/system use cases for operating the mining frigate
- You identified five Use Cases above. Rewrite them verb-first. Beside the main flow identify alternate flows and exception flows. Alternate flows account for variations in user behavior. Exception flows account for possible failure modes. List the Use Cases again accordingly. The main, alternate and exceptional flows shall be described within the section "Steps:". The section "Steps:" should be renamed "Objective:"
- Model the use cases in SysML v2.
- Use Cases require a feature named "subject". In this case the subject is always the miningSpaceship. The actors are features and shall be declared separately with the keyword "actor". The objective is a feature that contains a documentation element with the description of the flows.
- do not use interfaces as actors. Only parts of the domain.
- Do you see possible included use cases that can be refactorized?
- model the main five use cases with the new included four use cases
- documentation follows this format: doc /* {text first line} * {text line x} */
- Declare the use cases as shown in this example:
    
    // Use Case Mining Asteroid
    use case mineAsteroids : MineAsteroids {
    	first start;
    	then include use case navigateToDestination : NavigateToDestination {
    		actor :>> pilot = navigateToDestination::pilot;
    	}
    	then include use case transferCargo : TransferCargo {
    		actor :>> pilot = transferCargo::pilot;
    	}   
    }
- ...