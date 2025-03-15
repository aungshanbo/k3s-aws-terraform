# k3s-aws-terraform

## Overview

This project automates the deployment of a highly available [K3s](https://k3s.io/) Kubernetes cluster on AWS using Terraform. It leverages AWS EC2 Auto Scaling to ensure scalability and resilience.

## Features

- **Automated Deployment:** Utilizes Terraform to provision AWS infrastructure and set up K3s.
- **High Availability:** Configures EC2 Auto Scaling for master and worker nodes to maintain desired cluster size and Watch the Node Ready and Node Ready to delete with cron service.
- **Cost-Effective:** Implements a lightweight Kubernetes distribution suitable for various workloads.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed
- AWS account with appropriate permissions
- [AWS CLI](https://aws.amazon.com/cli/) configured

## Usage

1. **Clone the repository:**

   ```bash
   git clone https://github.com/aungshanbo/k3s-aws-terraform.git
