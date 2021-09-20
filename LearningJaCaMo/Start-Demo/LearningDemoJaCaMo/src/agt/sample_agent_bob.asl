// Agent sample_agent in project learningDemoJaCaMo

/* Initial beliefs and rules */

/* Initial goals */

!start.

/* Plans */

// +!start : true <- .print("hello world.").
// +!say(M) <- .print(M) .

// +!say(M) <- .print(M);
//             .send(alice,achieve,say("World")).

+!say(M) <- writeMsg(M).

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation
//{ include("$moiseJar/asl/org-obedient.asl") }
