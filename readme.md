# Hackathon 7SOAT Video Processor - Infrastructure

## Overview

This repository contains the Infrastructure as Code (IaC) configuration for the **Video Image Extraction** system. The IaC is implemented using **Terraform** to provision cloud infrastructure and **Kubernetes** to orchestrate various service containers essential for the project.

## Contents

- [Infrastructure](./docs/infrastructure.md)
- [Kubernetes](./docs/kubernetes.md)
- [Terraform](./docs/terraform.md)
- [Load Tests](./docs/load-tests.md)

## Structure

```
├── docs
│   ├── architecture.md
│   ├── assets
│   ├── infrastructure.md
│   ├── kubernetes.md
│   └── terraform.md
├── kubernetes
│   ├── global
│   ├── monitoring
│   ├── video-processor-api
│   └── video-processor-worker
├── load-tests
│   ├── node_modules
│   ├── package.json
│   ├── package-lock.json
│   └── video-processor-worker-load-test.js
├── readme.md
└── terraform
    ├── add-ons
    ├── main.tf
    ├── modules
    ├── values.tfvars
    └── variables.tf
```