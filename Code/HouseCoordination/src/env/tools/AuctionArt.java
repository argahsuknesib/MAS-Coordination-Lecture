package tools;

import cartago.Artifact;
import cartago.OPERATION;
import cartago.ObsProperty;

/**
 *      Artifact that implements the auction.
 */
public class AuctionArt extends Artifact {


    @OPERATION public void init(String taskDs, int maxValue, double reputation)  {
        // observable properties
        defineObsProperty("task",          taskDs);
        defineObsProperty("maxValue",      maxValue);
        defineObsProperty("currentBid",    maxValue);
        defineObsProperty("currentWinner", "no_winner");
        defineObsProperty("reputation", reputation);
        System.out.println("Auction Artifact for "+taskDs+" max "+maxValue+" has been initialized");
        System.out.println("Reputation for " +taskDs + "is " + reputation);
    }

    @OPERATION public void bid(double bidValue, double secondReputation) {
        ObsProperty opCurrentValue  = getObsProperty("currentBid");
        ObsProperty opCurrentWinner = getObsProperty("currentWinner");
        if (bidValue < opCurrentValue.doubleValue()) {  // the bid is better than the previous
            opCurrentValue.updateValue(bidValue);
            opCurrentWinner.updateValue(getCurrentOpAgentId().getAgentName());
        }
        ObsProperty opReputation = getObsProperty("reputation");
        if (secondReputation > opReputation.doubleValue()){
            opReputation.updateValue(secondReputation);
        }
    }
}

