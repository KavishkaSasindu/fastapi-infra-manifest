# FastAPI Infrastructure & Manifests

![GitOps](https://img.shields.io/badge/GitOps-Enabled-blue?logo=argo&logoColor=white)
![Kubernetes](https://img.shields.io/badge/Kubernetes-Manifests-326ce5?logo=kubernetes&logoColor=white)
![Terraform](https://img.shields.io/badge/Infrastructure-Terraform-7B42BC?logo=terraform&logoColor=white)

## 📖 Overview

This repository serves as the **Single Source of Truth** for the deployment state of the FastAPI application. It follows the **GitOps** methodology, where the desired state of the infrastructure and application deployment is version-controlled here, separate from the application source code.

This repository is monitored by **ArgoCD**, which automatically synchronizes any changes (such as new image tags or configuration updates) to the Kubernetes cluster.

#### This project follows a GitOps workflow. 
The application and the pipeline  are maintained in the [Infrastructure/Manifest Repository](https://github.com/KavishkaSasindu/jenkins-CICD-fastapi).

## 📂 Repository Structure

| Path | Description |
| :--- | :--- |
| **`/fastapi-app-helm`** | The **Helm Chart** defining the Kubernetes resources (Deployment, Service, Ingress) for the application. |
| **`/aws`** | **Terraform (HCL)** configurations for provisioning cloud resources (e.g., EKS, ECR, VPC). |
| **`argo-application.yaml`** | The **ArgoCD Application Manifest**. This file tells ArgoCD where to find the Helm chart and where to deploy it. |

## 🔄 GitOps Workflow

1.  **CI Trigger:** The Jenkins pipeline in the [Application Repository](LINK_TO_YOUR_APP_REPO_HERE) builds a new Docker image.
2.  **Manifest Update:** Jenkins automatically commits the new Docker image tag to the `values.yaml` inside `fastapi-app-helm/`.
3.  **Sync:** ArgoCD detects the commit in this repository.
4.  **Deployment:** ArgoCD syncs the changes, instructing Kubernetes to pull the new image and update the pods.

## 🚀 Deployment Instructions

### Prerequisites
* Kubernetes Cluster up and running.
* ArgoCD installed in the `argocd` namespace.
* AWS Credentials configured (if running Terraform).

# Example: fastapi-app-helm/values.yaml
```
replicaCount: 2
image:
  repository: <your-ecr-repo>
  tag: "v1.0.0" # This is updated automatically by Jenkins
service:
  type: LoadBalancer
  port: 80
```
