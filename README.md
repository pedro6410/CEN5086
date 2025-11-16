# Sequence Diagram — CompletePartyPlan flow

This repository contains a demo stack for a browser-based chat UI that calls Amazon Lex V2. The sequence diagram below shows how a user interacts with the hosted static site and how Lex delegates fulfillment to a Lambda which calls Bedrock to generate the party plan.

```mermaid
sequenceDiagram
    participant User
    participant CloudFront
    participant S3
    participant Browser
    participant Cognito
    participant Lex
    participant Lambda
    participant Bedrock

    User->>CloudFront: GET /index.html
    CloudFront->>S3: GET object (index.html)
    S3-->>CloudFront: 200 OK (index.html)
    CloudFront-->>User: 200 OK (index.html)

    Note over Browser, Cognito: Browser initializes AWS SDK
    Browser->>Cognito: GetId / GetCredentials (unauthenticated)
    Cognito-->>Browser: Temporary AWS credentials

    Note over Browser, Lex: User enters request
    Browser->>Lex: RecognizeText/PostText (signed with temp creds)
    Lex->>Lambda: Invoke fulfillment code hook
    Lambda->>Bedrock: Call model with generated prompt
    Bedrock-->>Lambda: Model response (plan text)
    Lambda-->>Lex: Fulfillment response (sessionState set to Fulfilled)
    Lex-->>Browser: Bot response
    Browser-->>Browser: Render message (sanitized Markdown)

```

Files

- `diagrams/sequence.puml` — PlantUML source for the same sequence diagram.

Notes

- The Mermaid diagram above renders on GitHub and many Markdown viewers. The PlantUML file can be used to generate PNG/SVG using PlantUML.
- This diagram assumes the static site is served via CloudFront (private S3 origin, OAI), the browser uses an unauthenticated Cognito Identity Pool to obtain temporary credentials, and Lex V2 calls the Lambda fulfillment hook which in turn calls Bedrock (via an SDK) to generate the plan.
