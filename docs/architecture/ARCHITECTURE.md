# CloudShield Architecture

## Overview

CloudShield is a lightweight Internal Developer Platform (IDP) that automates
AWS infrastructure provisioning and Kubernetes application deployment through
configuration.

This document describes the **v1 architecture**.

---

## v1 Architecture

                           Developer
                               │
                               ▼
                    GitHub Repository
          (Application + Terraform + apps/*.yaml)
                               │
                 ┌─────────────┴─────────────┐
                 │                           │
                 ▼                           ▼
        Infrastructure Change         Application Change
                 │                           │
                 ▼                           ▼
      GitHub Actions (Infra)      GitHub Actions (Deploy)
                 │                           │
                 ▼                           ▼
      Terraform reads IaC         Reads apps/teamforge.yaml
                 │                           │
                 ▼                           ▼
        AWS Infrastructure         Docker Build
        (VPC, EC2, Security)              │
                 │                        ▼
                 ▼                Container Registry
          EC2 hosts k3s                   │
                 │                        ▼
                 └──────────────► k3s Kubernetes
                                      │
                                      ▼
                              Application Running

---

## Components (v1)

- GitHub Repository
- GitHub Actions
- Terraform
- AWS (VPC, EC2, Security Groups)
- EC2 (hosts k3s)
- k3s Kubernetes
- Docker
- Container Registry
- Configuration (`apps/*.yaml`)

---

## Planned Components

### v2
- Multiple application support

### v3
- Prometheus
- Grafana

### v4
- tfsec
- Trivy

### v5
- ArgoCD (GitOps)

---

## Goal

Provide a reusable Internal Developer Platform where infrastructure and
application deployments are driven through configuration instead of manual
operations.