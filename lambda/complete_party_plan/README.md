# CompletePartyPlan Lambda

This folder contains a minimal AWS Lambda handler for fulfilling the `CompletePartyPlan` intent from an Amazon Lex V2 bot.

Files:
- `handler.py` — Python 3.9+ Lambda handler.

Quick notes:
- The Terraform resource in the repo references `lambda/complete_party_plan/deployment.zip` as the function package.
- Before running `terraform apply`, create the zip package (example below).

Create deployment package (run from repository root):

```bash
cd lambda/complete_party_plan
zip -r ../deployment.zip handler.py
cd ../..
```

After creating `deployment.zip`, run your normal Terraform workflow: `terraform init` then `terraform apply`.
