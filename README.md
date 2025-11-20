# Party Planner Bot — AWS Architecture

This repository contains a demo stack for a browser-based chat UI that calls Amazon Lex V2. The diagrams below show the architecture and request flow.

## Architecture Diagram

![AWS Architecture](diagrams/aws-architecture.png)

The stack includes:

- **CloudFront + S3**: Static chat UI (index.html) served via CDN with private S3 origin and OAI
- **Cognito Identity Pool**: Unauthenticated identities for browser access
- **Amazon Lex V2**: Conversational bot with `CompletePartyPlan` intent
- **Lambda**: Fulfillment handler that extracts slots and calls Bedrock
- **Amazon Bedrock**: Claude LLM to generate personalized party plans

## Sequence Diagram

![Sequence Diagram](diagrams/sequence.png)

The sequence shows the request flow:

1. Browser fetches `index.html` from CloudFront
2. Browser authenticates with Cognito (unauthenticated identity)
3. Browser sends message to Lex V2 (signed with temporary credentials)
4. Lex invokes Lambda fulfillment hook
5. Lambda calls Bedrock with a prompt built from Lex slots
6. Bedrock returns the generated plan
7. Lambda returns the fulfillment result to Lex
8. Lex returns the bot response to the browser
9. Browser renders the message as sanitized Markdown

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

- `diagrams/aws-architecture.puml` — PlantUML source for the architecture diagram
- `diagrams/aws-architecture.png` — Rendered PNG (AWS resources and flow)
- `diagrams/sequence.puml` — PlantUML source for the sequence diagram
- `diagrams/sequence.png` — Rendered PNG (request sequence)

Notes

- The Mermaid diagram renders on GitHub and many Markdown viewers. The PNG files provide high-quality rendered versions.
- The PlantUML source files can be regenerated or customized using `plantuml -tpng diagrams/*.puml`
- This diagram assumes the static site is served via CloudFront (private S3 origin, OAI), the browser uses an unauthenticated Cognito Identity Pool to obtain temporary credentials, and Lex V2 calls the Lambda fulfillment hook which in turn calls Bedrock to generate the plan.
