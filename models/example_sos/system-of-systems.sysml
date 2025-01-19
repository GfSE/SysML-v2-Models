package 'system-of-systems' {
	/* This package defines a system-of-systems as
	 * an aggregation of systems in the context of 
	 * their respective owning enterprises using 
	 * SysMLv2 notation
	 */
	//definition of parts
	part def Enterprise;
	part def System_a;
	part def System_b;
	part def System_c;
	
	//definition of individuals
	individual part def Enterprise_alpha :> Enterprise {
		part system_a_alpha : System_a;
	}
	individual part def Enterprise_beta {
		part system_a_beta : System_a;
		part system_b_beta : System_b;
	}
	
	individual part def System_a1 :> System_a;
	individual part def System_a2 :> System_a;
	individual part def System_b1 :> System_b;
	individual part def System_c1 :> System_c;
	
	//declaration of individuals
	individual part enterprise_alpha : Enterprise_alpha {
		individual part system_a1 : System_a1 :>> system_a_alpha; 
	}
	
	individual part enterprise_beta : Enterprise_beta {
		individual part system_a2 : System_a2 :>> system_a_beta;
		individual part system_b1 : System_b1 :>> system_b_beta; 
	}
	
	//definitions of possible configurations of systems
	individual part 'not system-of-systems' : System_c1 {
		doc /* This agregation of systems does
		 * not constitute a system-of-systems because
		 * all involved systems are contextualized
		 * in the same enterprise. 
		 */
		individual part system_a2 : System_a2;
		individual part system_b1 : System_b1;
	}
	individual part 'system-of-systems' : System_c1 {
		doc /* This agregation of systems does
		 * constitute a system-of-systems because
		 * the involved systems are contextualized
		 * in different enterprises. 
		 */
		individual part system_a1 : System_a1;
		individual part system_a2 : System_a2;		
	}
}