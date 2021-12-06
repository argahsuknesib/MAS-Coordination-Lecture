// Agent companyQ1

/* Initial beliefs and rules */
// client(giacomo, 20).
// client(andrei, 30).
client(giacomo, 100).
client(andrei, 200).
skill(plumbing).
/* Initial goals */

!start. // comment or uncomment to start and stop the interaction.

/* Plans */

+!needDelay(S,D) : skill(X) & S == X & client(C,V)
  <-
  !proposeDelay(C,S,D).      

+delay_limit(CoL)[source[Cli]] <- if (ClL > CoL){
    .send(Cli, tell, delay(CoL));
    /* On checking the HTTP server of Jason,
    you will find the belief if this loop is called.
    */

}
elif(ClL < CoL){
    .println("error message informing failure in completing the task");
}.

+! start : true <- for(client(Cli, CoL)){
    .send(Cli, askOne, delay_limit(X));
    .send(Cli, askOne, delay_limit(Y));
    +delay_limit(Value)[source[Cli]];
};

/*
.send(companyA, achieve, needDelay(plumbing, 10)).
make a REPL agent 'director' and execute the code to companyA
*/ 

.findall(delay_limit(ClL)[source(Cli)],
        delay_limit(ClL)[source(Cli)],
        List
);
.max(List, delay_limit(ClL)[source(Cli)]);
.println("Client with the greatest delay_limit is ", Cli);.



{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation
//{ include("$moiseJar/asl/org-obedient.asl") }
