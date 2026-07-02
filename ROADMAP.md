# 🗺 CloudShield Roadmap

This roadmap tracks CloudShield's evolution from a working platform foundation to a full Internal Developer Platform (IDP Lite). Each version has a clear "definition of done" — once every item is checked, that version is complete and the next one begins.

---

## Version 1 — Platform Foundation
**Goal:** Prove the core loop works — config in, running app out — with zero hardcoded app logic in the platform.

- [ ] `apps/teamforge.yaml` config file defines app name, repo, port, replicas, env vars
- [ ] Terraform provisions: VPC, subnet, security group, EC2 instance
- [ ] k3s installed and running on the EC2 instance (via Terraform provisioner or user-data script)
- [ ] Terraform remote state configured in S3 with DynamoDB locking
- [ ] Dockerfile builds TeamForge (client + server) into a container image
- [ ] GitHub Actions workflow: on push to TeamForge repo → build image → push to a registry (Docker Hub or ECR)
- [ ] GitHub Actions workflow: reads `apps/teamforge.yaml` → applies Kubernetes manifests → deploys to k3s
- [ ] Manual verification: app is reachable at the EC2 public IP on the configured port
- [ ] README + architecture diagram documenting v1 flow

**Definition of done:** Pushing a code change to TeamForge results in an updated, running deployment on k3s, with no manual SSH or manual `kubectl apply` steps, and no TeamForge-specific logic hardcoded into the pipeline (only the YAML config is app-specific).

---

## Version 2 — Reusability & Multi-App Support
**Goal:** Prove the "config-driven" claim by deploying a second, different app without changing the platform.

- [ ] Add a second app config, e.g. `apps/portfolio.yaml` (a simple static or Node app)
- [ ] Confirm CloudShield deploys it using the same pipeline, zero platform code changes
- [ ] Kubernetes manifests templated (Helm chart or Kustomize) instead of hardcoded per app
- [ ] Namespace-per-app isolation in k3s
- [ ] Basic rollback: pipeline redeploys previous image tag on health-check failure

**Definition of done:** Two different apps are running on CloudShield, each defined by nothing but a config file, and adding an app required zero edits to Terraform or pipeline code.

---

## Version 3 — Observability
**Goal:** Know whether a deployed app is actually healthy, not just "running."

- [ ] Prometheus deployed on k3s (via Helm)
- [ ] Grafana deployed, connected to Prometheus
- [ ] Dashboard showing CPU, memory, pod restarts, request count for at least one app
- [ ] One real Alertmanager rule configured (e.g., pod crash-looping, or app down for >2 min)
- [ ] Alert routed somewhere real (email, Slack webhook, or similar)
- [ ] Runbook doc: what to do when the alert fires

**Definition of done:** You can break the app on purpose, watch the dashboard reflect it, get an alert, and follow your own runbook to recover it.

---

## Version 4 — Security Automation
**Goal:** Catch infrastructure and code risks before they ever reach production.

- [ ] tfsec integrated into the GitHub Actions pipeline — Terraform plan fails the build on high-severity findings
- [ ] Secrets (DB credentials, API keys) moved out of plaintext env vars into AWS SSM Parameter Store or Kubernetes Secrets (sealed/encrypted, not plaintext in git)
- [ ] IAM role for the deploy pipeline scoped to least privilege (no admin/root credentials used by GitHub Actions)
- [ ] GitHub secret scanning enabled on the repo
- [ ] Security section in docs explaining each control and why it exists

**Definition of done:** A deliberately insecure Terraform change (e.g., open security group) fails the pipeline automatically, and no plaintext secret exists anywhere in the repo or pipeline logs.

---

## Version 5 — GitOps
**Goal:** The platform reconciles itself instead of being pushed to.

- [ ] ArgoCD installed on k3s
- [ ] ArgoCD watches the `apps/` folder directly
- [ ] Changing a config file (e.g., bumping replicas) auto-syncs without a GitHub Actions deploy step
- [ ] Drift detection demonstrated: manually change something in the cluster, show ArgoCD reverts it
- [ ] Docs updated to reflect GitOps as the deployment model, CI now only builds/pushes images

**Definition of done:** You can explain, and demo, the difference between "pipeline pushes changes" (v1–v4) and "cluster pulls and reconciles changes" (v5) — and show drift correction happening live.

---

## Deferred / Out of Scope (for now)

These are deliberately excluded to keep the project finishable. Revisit only if time allows after internship applications are underway.

- EKS migration (k3s is sufficient to demonstrate the same concepts)
- Auto-scaling / HPA tuning beyond basic replica counts
- Multi-cloud support
- Loki/Promtail logging stack (kubectl logs is sufficient for this scope)
- Blue-green or canary deployments
- Cost dashboards / FinOps tooling

---

## Current Status

🟡 **In progress: Version 1**