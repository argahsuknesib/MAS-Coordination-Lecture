// This company bids for all tasks
// Strategy: bids a random value

// Inclusion of standards agent's behavior to make agents able to work in an JaCaMo environment
{ include("$jacamoJar/templates/common-cartago.asl") }
// Inclusion of common behaviors for this application
{ include("common.asl") }

// initial belief
my_task("SitePreparation").
my_task("Floors").
my_task("Walls").
my_task("Roof").
my_task("WindowsDoors").
my_task("Plumbing").
my_task("ElectricalSystem").
my_task("Painting").

// initial goal to discover artifact
!start.

// my reputation
my_reputation(0.3).

+task(S)[artifact_id(Art)]
   <- .wait(math.random(500)+50);
      Bid = math.floor(math.random(10000))+800;
      // .print("my bid in auction artifact ", Art, " is ",Bid);
      bid( Bid )[artifact_id(Art)]. // recall that the artifact ignores if this
                                    // agent places a bid that is higher than
                                    // the current bid

/* Sending Tasks to Giacomo Agent for Presentation */

+!send_taks : true <-  .send(giacomo, tell, value("SitePreparation"));
         .send(giacomo, tell, value("Floors"));
         .send(giacomo, tell, value("Walls"));
         .send(giacomo, tell, value("WindowsDoors"));
         .send(giacomo, tell, value("Plumbing"));
         .send(giacomo, tell, value("ElectricalSystem"));
         .send(giacomo, tell, value("Painting")).

// this will add the literal value("Example")[source(companyD)] to 
// the giacomo agent's belief base'

/* plans for execution phase */

{ include("org_code.asl") }
{ include("skills.asl") }
