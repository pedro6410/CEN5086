# CompletePartyPlan Lambda

Fulfillment handler for the `CompletePartyPlan` Lex V2 intent.

## What it does

1. Receives a Lex V2 fulfillment request with party slots (guest count, theme, dietary restrictions)
2. Builds an AI prompt from the slot values
3. Calls Amazon Bedrock (Llama 3.1 8B) with guardrails enabled
4. Returns the generated party plan to Lex (marked as Fulfilled)

## Files

- `handler.py` — Python 3.9+ Lambda handler (boto3 required)

## Deployment

Packaging is automated in Terraform (`data.archive_file` in `lambda.tf`). Simply run:

```bash
terraform apply
```

The `lambda.tf` resource will package this folder and deploy it automatically.
