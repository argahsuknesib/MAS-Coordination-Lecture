// Agent clientQ1a

/* Initial beliefs and rules */
delay_limit(10). //initial delay_limit
// delay_limit(80). // just to check
// delay_limit(2).
penalty(plumbing, 50).

/* Initial goals */

/* Plans */

+!updateTolerance(V) :
    delay_limit(L) & L > V
	<-
	.print("update tolerance");
	-+delay_limit(L-V).

+delay(CoL)[source(C)]:delay_limit(PL) & PL > CoL <-
		-+delay_limit(CoL);.
   
{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation
//{ include("$moiseJar/asl/org-obedient.asl") }
