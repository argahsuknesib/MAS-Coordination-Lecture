// Agent clientQ2 in project test

/* Initial beliefs and rules */
knowledge(limit_delay,plumbing, 50).
knowledge(penality, plumbing, 100).
action(update).
/* Initial goals */


/* Plans */

+!requestManagement(A, K, S, V)[source(Agent)]:
    action(A) & knowledge(limit_delay,plumbing, 50)
        <- 
            .println("Agree with the update.");
            .send(Agent, tell, inform).


+!requestManagement(A, limit_delay, S, V)[source(Agent)]:
    action(A) & knowledge(limit_delay,S, V1) & V1 < V 
    <-
        -+knowledge(A, K, S, V);
        .send(Agent, achieve, inform).

+!requestManagement(A, penalty, S, V)[source(Agent)]:
    action(A) & knowledge(penalty, S, V1) & V1 < V
        <- 
            -+knowledge(A,K, S, V);
            .send(Agent, achieve, inform).

/* 
not sure how to handle the failure, tried with making 
if and else but faced errors.

Instead I will try to generate a failure event if there are
less than 4 arguments in the requestManagement()
*/

+!requestManagement(A, penalty, S)[source(Agent)]: true <- .send(Agent, achieve, failure).
+!requestManagement(A, penalty, V)[source(Agent)]: true <- .send(Agent, achieve, failure).
+!requestManagement(A, S)[source(Agent)]: true <- .send(Agent, achieve, failure).
+!requestManagement(A, V)[source(Agent)]: true <- .send(Agent, achieve, failure).
+!requestManagement(A, limit_delay)[source(Agent)]: true <- .send(Agent, achieve, failure).
+!requestManagement(A, penalty)[source(Agent)]: true <- .send(Agent, achieve, failure).

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation
//{ include("$moiseJar/asl/org-obedient.asl") }
