import os
import sys

# Make lambda folder importable (tests/ sits at repo root)
sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "lambda", "complete_party_plan"))

from handler import lambda_handler


def test_lambda_handler_fulfilled():
    # Minimal Lex V2-like event with two slots present
    event = {
        "sessionState": {
            "intent": {
                "name": "CompletePartyPlan",
                "slots": {
                    "partyType": {"value": {"interpretedValue": "birthday"}},
                    "GuestCount": {"value": {"interpretedValue": "20"}},
                },
            }
        }
    }

    res = lambda_handler(event, None)

    assert "sessionState" in res
    assert res["sessionState"]["intent"]["state"] == "Fulfilled"
    assert "messages" in res and len(res["messages"]) > 0
