# CEN5086 - Architecture Diagram

This file contains a high-level architecture diagram (Mermaid) showing the resources deployed by this repository and how data flows between them.



## Components

- Browser (index.html) — Hosted on S3 + CloudFront. The page contains the JS client that authenticates via Cognito (unauthenticated) and calls Lex.
- CloudFront — Distributes `index.html` and static assets using an Origin Access Identity (OAI) to read the S3 origin.
- S3 Bucket (`party-bot-content`) — Stores `index.html` and static assets. Bucket is private; CloudFront OAI grants access.
- Cognito Identity Pool — Provides unauthenticated credentials to the browser so it can call AWS services (Lex).
- Amazon Lex V2 Bot — Handles user input; configured with `CompletePartyPlan` intent. Uses a fulfillment Lambda.
- Lambda (`CompletePartyPlan`) — Fulfillment code (calls Bedrock, prepares responses). Has an execution role.
- Amazon Bedrock — (Optional) LLM used by the Lambda to generate plans.
- CloudWatch Logs — Lambda and other services log here.
- Terraform — Manages the infrastructure; includes automation to upload `index.html` and invalidate CloudFront when content changes.





