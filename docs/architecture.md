# CEN5086 - Architecture Diagram

This file contains a high-level architecture diagram (Mermaid) showing the resources deployed by this repository and how data flows between them.

```mermaid
flowchart LR
  subgraph Client[Client]
    Browser[User Browser\n(index.html on CloudFront)]
  end

  Browser -->|HTTPS| CloudFront[CloudFront Distribution]
  CloudFront -->|S3 GetObject (OAI)| S3[S3 Bucket\n(party-bot-content)]

  Browser -->|Cognito unauthenticated identity| Cognito[Cognito Identity Pool]
  Browser -.->|Uses temporary credentials| Lex[Amazon Lex V2 Bot]

  Lex -->|Fulfillment hook| Lambda[Lambda: CompletePartyPlan]
  Lambda -->|Calls| Bedrock[Amazon Bedrock]
  Lambda -->|Logs| CloudWatch[CloudWatch Logs]

  CloudFront -->|Invalidation| Terraform[Terraform / CI]
  Terraform -->|Creates| S3
  Terraform -->|Creates| CloudFront
  Terraform -->|Creates| Lambda
  Terraform -->|Creates| Cognito
  Terraform -->|Creates| Lex

  classDef awsService fill:#eef,stroke:#333,stroke-width:1px;
  classDef infra fill:#dfd,stroke:#333,stroke-width:1px;

  class S3,CloudFront,Lex,Lambda,Cognito,Bedrock,CloudWatch awsService;
  class Terraform infra;
```

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

## How to render

- GitHub: Mermaid diagrams in Markdown may render automatically in some views/previewers.
- Locally: use a Mermaid CLI or an online Mermaid live editor: https://mermaid.live
- For a PlantUML version, see `diagrams/architecture.puml` in the repository.


---

If you'd like, I can also:
- Generate and commit an SVG/PDF export of the diagram.
- Create a more detailed sequence diagram showing a complete request flow (browser -> Cognito -> Lex -> Lambda -> Bedrock -> response).
- Add this diagram to the repository README.
