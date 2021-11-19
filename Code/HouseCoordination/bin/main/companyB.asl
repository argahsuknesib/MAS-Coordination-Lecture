// This company bids for site preparation
// Strategy: decreasing its price by 150 until its minimal value

// Inclusion of standards agent's behavior to make agents able to work in an JaCaMo environment
{ include("$jacamoJar/templates/common-cartago.asl") }
// Inclusion of common behaviors for this application
{ include("common.asl") }

// initial belief
my_price(1500). 
my_task("SitePreparation").

//my reputation
my_reputation(0.6).

// initial goal to discover artifact
!start.

+currentBid(V)[artifact_id(Art)]        // there is a new value for current bid
    : not i_am_winning(Art) &           // I am not the winner
      my_price(P) & P < V               // I can offer a better bid
   <- //.print("my bid in auction artifact ", Art, " is ",math.max(V-150,P));
      bid( math.max(V-150,P) ).         // place my bid offering a cheaper service

/* Sending Tasks to Giacomo Agent for Presentation */

+!send_tasks : true <- .send(giacomo, tell, value("SitePreparation")).

// this will add the literal value("SitePreparation")[source(companyB)] to giacomo's belief base

/* plans for execution phase */

{ include("org_code.asl") }
{ include("skills.asl") }

