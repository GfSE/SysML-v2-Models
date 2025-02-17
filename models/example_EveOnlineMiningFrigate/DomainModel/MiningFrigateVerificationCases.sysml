package MiningFrigateRequirementsVerification {

    private import MiningFrigateRequirements::*;
    private import StakeholdersDef::*;
    private import Domain::*;
    private import ScalarValues::*;
    private import ISQ::*;
	private import SI::*;
	private import VerificationCases::*;
	private import MiningFrigate::*;

	//Verifications at the problem/operational level
	//These are incidentally the validation actions for the system/soution level
	
	// Definition of a test rig that includes all necessary verification parts
	//Verification actions are assigned to the parts of the verification domain
    part def MiningFrigateTestRig {
        part testMiningFrigate : MiningFrigate;
        part testEngineer : ShipEngineer;
        part testEnvironment : TestEnvironment;
        part dataLogger : DataLogger;
    }
	
    part def TestEnvironment {
        doc /* The TestEnvironment provides the controlled conditions needed 
               to execute tests on the Mining Frigate, such as simulated asteroid belts, 
               hostile encounters, and docking stations. */
    	perform action simulateLowSecAttack;
    }

    part def DataLogger {
        doc /* The DataLogger records test data, including ore extraction rates, 
               cargo capacity, shield strength, and other key performance metrics. */
        perform action evaluateData;
    }
    
    part def ShipEngineer {
        doc /* The ShipEngieer is both a stakeholder and an actor in the verification domain */
    }	
	
	part miningFrigateDUT : MiningFrigate {
		doc /* The miningFrigateDUT is a test unit */
		perform action collectData;
		perform action deployDrones;
	}

	
	//Verification
	verification oreExtractionEfficiencyTest : OreExtractionEfficiencyTest {
		subject testMiningFrigate :> miningFrigateDUT;
	}
	verification cargoCapacityTest : CargoCapacityTest {
		subject testMiningFrigate :> miningFrigateDUT;
	}
	verification survivabilityTest : SurvivabilityTest {
		subject testMiningFrigate :> miningFrigateDUT;
	}
	verification droneOperationsTest : DroneOperationsTest {
		subject testMiningFrigate :> miningFrigateDUT;
	}
	verification threatDetectionTest : ThreatDetectionTest {
		subject testMiningFrigate :> miningFrigateDUT;
	}

	// Verification definitions 
    // Verification Definition for Ore Extraction Efficiency
    verification def OreExtractionEfficiencyTest {
        subject testMiningFrigate : MiningFrigate;

        objective oreExtractionEfficiencyVerification {
            // The subject of the verify is automatically bound to "testMiningFrigate".
            verify oreExtractionEfficiencyRequirementLowSec ;
        }
        metadata VerificationMethod {
			kind = VerificationMethodKind::test;
		}

        action collectData {
            in part testMiningFrigate : MiningFrigate = OreExtractionEfficiencyTest::testMiningFrigate;
            out miningRateMeasuredHS : Real ; // High Sec (m³/min)
            out miningRateMeasuredLS : Real; // Low Sec, Null Sec, Wormholes
        }

        action evaluateData {
            in miningRateMeasuredLS = collectData.miningRateMeasuredLS;
            out verdict : VerdictKind =
            // Check if mining rates satisfy the OreExtractionEfficiencyRequirement.
            PassIf(oreExtractionEfficiencyRequirementLowSec(
            	testMiningFrigate,
                miningRateMeasuredLS));
        }

        return :>> verdict : VerdictKind = evaluateData.verdict;
    }

    // Verification Definition for Cargo Capacity
    verification def CargoCapacityTest {
        subject testMiningFrigate : MiningFrigate;

        objective cargoCapacityVerification {
            // The subject of the verify is automatically bound to "testMiningFrigate".
            verify cargoCapacityRequirementLowSec;
        }

        metadata VerificationMethod {
            kind = VerificationMethodKind::test;
        }

        action collectData {
            in part testMiningFrigate : MiningFrigate = CargoCapacityTest::testMiningFrigate;
            out cargoCapacityMeasured : Real;
        }

        action evaluateData {
            in cargoCapacityMeasured : Real = collectData.cargoCapacityMeasured;
            out verdict : VerdictKind =
            // Check if cargo capacity satisfies the CargoCapacityRequirement.
            PassIf(cargoCapacityRequirementLowSec(
                testMiningFrigate,
                cargoCapacityMeasured));
        }

        return verdict : VerdictKind = evaluateData.verdict;
    }

    // Verification Definition for Survivability
    verification def SurvivabilityTest {
        subject testMiningFrigate : MiningFrigate;

        objective survivabilityVerification {
            // The subject of the verify is automatically bound to "testMiningFrigate".
            verify survivabilityRequirementLowSec;
        }

        metadata VerificationMethod {
            kind = VerificationMethodKind::test;
        }

        action simulateHighSecAttack {
            in part testMiningFrigate : MiningFrigate = SurvivabilityTest::testMiningFrigate;
            out shieldStrengthMeasuredHS : Real; // High Sec survivability (DPS)
        }

        action simulateLowSecAttack {
            in part testMiningFrigate : MiningFrigate = SurvivabilityTest::testMiningFrigate;
            out shieldStrengthMeasuredLS : Real; // Low Sec survivability (DPS)
        }

        action evaluateData {
            in shieldStrengthMeasuredLS : Real = simulateLowSecAttack.shieldStrengthMeasuredLS;
            out verdict : VerdictKind =
            // Check if shield strength satisfies the SurvivabilityRequirement.
            PassIf(survivabilityRequirementLowSec(
                testMiningFrigate,
                shieldStrengthMeasuredLS));
        }

        return verdict : VerdictKind = evaluateData.verdict;
    }

    // Verification Definition for Drone Operations
    verification def DroneOperationsTest {
        subject testMiningFrigate : MiningFrigate;

        objective droneOperationsVerification {
            // The subject of the verify is automatically bound to "testMiningFrigate".
            verify droneOperationsRequirementLowSec;
        }

        metadata VerificationMethod {
            kind = VerificationMethodKind::test;
        }

        action deployDrones {
            in part testMiningFrigate : MiningFrigate = DroneOperationsTest::testMiningFrigate;
            out droneCapacityMeasured : Integer;
        }

        action evaluateData {
            in droneCapacityMeasured : Integer = deployDrones.droneCapacityMeasured;
            out verdict : VerdictKind =
            // Check if the drone capacity satisfies the DroneOperationsRequirement.
            PassIf(droneOperationsRequirementLowSec(
                testMiningFrigate,
                droneCapacityMeasured
            ));
        }

        return verdict : VerdictKind = evaluateData.verdict;
    }

    // Verification Definition for Threat Detection
    verification def ThreatDetectionTest {
        subject testMiningFrigate : MiningFrigate;

        objective threatDetectionVerification {
            // The subject of the verify is automatically bound to "testMiningFrigate".
            verify threatDetectionRequirementLowSec;
        }

        metadata VerificationMethod {
            kind = VerificationMethodKind::test;
        }

        action collectThreatDetectionData {
            in part testMiningFrigate : MiningFrigate = ThreatDetectionTest::testMiningFrigate;
            out threatDetectionRangeMeasured : Real;
        }

        action evaluateData {
            in threatDetectionRangeMeasured : Real = collectThreatDetectionData.threatDetectionRangeMeasured;
            out verdict : VerdictKind =
            // Check if the threat detection range satisfies the ThreatDetectionRequirement.
            PassIf(threatDetectionRequirementLowSec(
                testMiningFrigate,
                threatDetectionRangeMeasured
            ));
        }

        return verdict : VerdictKind = evaluateData.verdict;
    }
}
