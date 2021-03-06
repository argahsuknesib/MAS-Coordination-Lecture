// This company bids for Floors, Walls, and Roof
// Strategy: a fixed lowest price for doing all 3 tasks,
//           decrease the current bid by a fixed value

// Inclusion of standards agent's behavior to make agents able to work in an JaCaMo environment
{ include("$jacamoJar/templates/common-cartago.asl") }
// Inclusion of common behaviors for this application
{ include("common.asl") }

// initial belief
my_price(800). // minimum price for the 3 tasks
my_task("Floors").
my_task("Walls").
my_task("Roof").

// my reputation
my_reputation(0.8).


// a rule to calculate the sum of the current bids place by this agent
sum_of_my_offers(S) :-
   .my_name(Me) & .term2string(Me,MeS) &
   .findall( V,      // artifacts/auctions I am currently winning
             currentWinner(MeS)[artifact_id(ArtId)] &
             currentBid(V)[artifact_id(ArtId)],
             L) &
   S = math.sum(L).

// initial goal to discover artifact
!start.

/* Plans for Auction phase */

+currentBid(V)[artifact_id(Art)]      // there is a new value for current bid
    : not i_am_winning(Art) &         // I am not the winner
      my_price(P) &
      sum_of_my_offers(Sum) &
      task(S)[artifact_id(Art)] &
      P < Sum + V                     // I can still offer a better bid
   <- //.print("my bid in auction artifact ", Art, ", Task ", S,", is ",math.max(V-10,P));
      bid( math.max(V-10,P) )[ artifact_id(Art) ].  // place my bid offering a cheaper service


/* Sending Tasks to Giacomo Agent for Presentation */

+!send_taks : true <- .send(giacomo, tell, value("Floors"));
         .send(giacomo, tell, value("Walls"));
         .send(giacomo, tell, value("Roof")).

/*
this will add the literal value("Example)[source(companyE)]
to the giacomo agent's beief base 
*/

/* plans for execution phase */

{ include("org_code.asl") }
{ include("skills.asl") }
