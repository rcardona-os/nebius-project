# 🧪 GPU ML Training Lab on Nebius with Slurm + Real Kaggle Dataset

## 🔹 Objective

Create a real-world lab on Nebius that:
- Uses GPU-enabled compute resources
- Is managed by a **Slurm** HPC job scheduler
- Trains a model using a **real Kaggle dataset**
- Simulates a realistic AI research or production environment

---

## 🔹 Tools & Technologies

| Component              | Purpose                                         |
|------------------------|-------------------------------------------------|
| Nebius Compute Cloud   | GPU-enabled VMs (e.g., `gpu-standard-v100`)     |
| Slurm Workload Manager | HPC-style resource scheduling and job control   |
| PyTorch / TensorFlow   | For model training                              |
| Kaggle CLI             | To download datasets from Kaggle                |
| Object Storage / NFS   | Dataset and model artifact sharing              |
| JupyterLab (optional)  | For dev, experimentation, and monitoring        |

---

## 🔹 Architecture Overview

+-------------------+        +-----------------+
|   Login / Head    | <----> |   Compute Node  |
|     Node (Slurm)  |        |  (GPU Enabled)  |
+-------------------+        +-----------------+
        |
        | SSH / Slurm CLI / Jupyter
        |
        v
+------------------------+
|  Nebius Object Storage |
|  (Kaggle Datasets)     |
+------------------------+



---

## 🔹 Suggested Datasets (Kaggle)

| Dataset | Type | Link |
|--------|------|------|
| Cassava Leaf Disease | Image Classification | [🔗 Kaggle](https://www.kaggle.com/c/cassava-leaf-disease-classification) |
| House Prices | Regression | [🔗 Kaggle](https://www.kaggle.com/competitions/house-prices-advanced-regression-techniques) |
| Titanic Challenge | Binary Classification | [🔗 Kaggle](https://www.kaggle.com/c/titanic) |
| Dog Breed Identification | Deep CNN | [🔗 Kaggle](https://www.kaggle.com/c/dog-breed-identification) |

---

## 🚀 Lab Setup Plan

### 1. 🔧 Provision Infrastructure
- Create **Head Node** VM (Ubuntu 22.04)
- Create **Compute Node(s)** with GPU (e.g. `gpu-standard-v100`)
- Ensure nodes are on the same network

### 2. ⚙️ Install Slurm
On Head Node:
```bash
sudo apt install slurmctld slurmdbd
