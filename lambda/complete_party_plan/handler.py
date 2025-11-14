import json
import logging
import boto3

logger = logging.getLogger()
logger.setLevel(logging.INFO)


def lambda_handler(event, context):
    """Basic AWS Lambda handler to fulfill the CompletePartyPlan Lex V2 intent.

    This handler expects the Lex V2 request format and returns a simple
    fulfillment response that closes the conversation and marks the intent
    as fulfilled.

    It extracts slot values (if present) and includes a short summary in the
    response message.
    """
    logger.info("Received event: %s", json.dumps(event))

    try:
        session_state = event.get("sessionState", {})
        intent = session_state.get("intent", {})
        intent_name = intent.get("name", "CompletePartyPlan")

        # Extract slots safely
        slots = intent.get("slots") or {}
        # For readability, gather present slot values
        slot_values = {}
        for k, v in slots.items():
            if not v:
                continue
            # Lex V2 slot shape: { "value": { "interpretedValue": "..." }, ... }
            value = None
            if isinstance(v, dict):
                value_obj = v.get("value") or {}
                value = value_obj.get("interpretedValue")
            if value:
                slot_values[k] = value
        print("slot_values {}".format(slot_values))
        dietary_preferences = slot_values.get("DietaryRestrictions", "not specified")
        guest_count = slot_values.get("GuestCount", "not specified")
        party_theme = slot_values.get("partyType", "not specified")
        ai_prompt = "create a music playlist and food menu for a {0} party with {1} guests and {2} dietary restrictions".format(party_theme,guest_count , dietary_preferences)
        print("ai_prompt {}".format(ai_prompt))
        # Build a short human-friendly summary
        if slot_values:
            parts = [f"{k}={v}" for k, v in slot_values.items()]
            print("parts {}".format(parts))
            #summary = "I gathered: " + ", ".join(parts) + "."
            #call bedrock to get the response from AI
            client = boto3.client('bedrock-runtime')
            body = json.dumps({
                "prompt": ai_prompt,
               "max_gen_len": 512,
                 "temperature": 0.5,
            })
            response = client.invoke_model(
                modelId='meta.llama3-8b-instruct-v1:0',
                body=body,
                guardrailIdentifier='vbqqj3w3r44u',
                guardrailVersion = '1',
                contentType='application/json'
            )
            print("response {}".format(response))

             # Read the response body.
            model_response = json.loads(response["body"].read())
    

            # Extract and print the response text.
            response_text = model_response["generation"]
            print(response_text)
            summary = response_text
        else:
            summary = "I don't have any details yet, but I can help plan your party."

        message = (
            f"Your party plan is being prepared. {summary} "
            "I'll follow up with a suggested plan and next steps."
        )

        # Lex V2 expects a response containing sessionState and messages.
        response = {
            "sessionState": {
                "dialogAction": {"type": "Close"},
                "intent": {"name": intent_name, "state": "Fulfilled"},
            },
            "messages": [
                {"contentType": "PlainText", "content": message}
            ],
        }

        logger.info("Responding: %s", json.dumps(response))
        return response

    except Exception as e:
        logger.exception("Error handling Lex request")
        # On error, return a failure message but keep the conversation closed
        return {
            "sessionState": {
                "dialogAction": {"type": "Close"},
                "intent": {"name": "CompletePartyPlan", "state": "Failed"},
            },
            "messages": [
                {"contentType": "PlainText", "content": "Sorry, something went wrong while planning your party."}
            ],
        }
