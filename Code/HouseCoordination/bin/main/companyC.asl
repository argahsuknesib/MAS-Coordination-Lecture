// This company can bid for all types tasks,
// but can commit to at most 2 of them
// Strategy: fixed price

// Inclusion of standards agent's behavior to make agents able to work in an JaCaMo environment
{ include("$jacamoJar/templates/common-cartago.asl") }
// Inclusion of common behaviors for this application
{ include("common.asl") }

// a rule to help the agent infer whether it can commit to another task
can_commit :-
   .my_name(Me) & .term2string(Me,MeS) &
   .findall( ArtId, currentWinner(MeS)[artifact_id(ArtId)], L) &
   .length(L,S) & S < 2.

// initial beliefs about valuations for the auction
my_price("SitePreparation", 1900).
my_price("Floors",           900).
my_price("Walls",            900).
my_price("Roof",            1100).
my_price("WindowsDoors",    2000).
my_price("Plumbing",         600).
my_price("ElectricalSystem", 300).
my_price("Painting",        1100).

// initial belief
my_task("SitePreparation").
my_task("Floors").
my_task("Walls").
my_task("Roof").
my_task("WindowsDoors").
my_task("Plumbing").
my_task("ElectricalSystem").
my_task("Painting").

// my reputation
my_reputation(0.3).

// initial goal to discover artifact
!start.

@lbo[atomic] // atomic to ensure it still winning less than two when the bid is placed
+currentBid(V)[artifact_id(Art)]        // there is a new value for current bid
    : task(S)[artifact_id(Art)] &
      my_price(S,P) &                   // get my valuation for this service
      not i_am_winning(Art) &           // I am not the winner
      P < V &                           // I can offer a better bid
      can_commit                        // I can still commit to another task
   <- // .print("my bid in auction artifact ", Art, ", Task ", S, ", is ", P);
      bid( P )[ artifact_id(Art) ].     // place my bid offering a cheaper service

/* plans for execution phase */

/* Sending Tasks to Giacomo Agent for Presentation */
+!send_taks : true <- .send(giacomo, tell, value("SitePreparation"));
      .send(giacomo, tell, value("Floors"));
      .send(giacomo, tell, value("Walls"));
      .send(giacomo, tell, value("Roof"));
      .send(giacomo, tell, value("WindowsDoors"));
      .send(giacomo, tell, value("Plumbing"));
      .send(giacomo, tell, value("ElectricalSystem"));
      .send(giacomo, tell, value("Painting")).

// this will add the literal value("Example")[source(companyC)] to 
// the giacomo agent's belief base'

{ include("org_code.asl") }
{ include("skills.asl") }
