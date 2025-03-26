# 🧪 GPU ML Training Lab on Nebius with Slurm + Real Kaggle Dataset

## 🎯 Objective

Create a real-world lab on Nebius that:
- Uses GPU-enabled compute resources
- Is managed by a **Slurm** HPC job scheduler
- Trains a model using a **real Kaggle dataset**
- Simulates a realistic AI research or production environment

---

## 🧰 Tools & Technologies

| Component              | Purpose                                         |
|------------------------|-------------------------------------------------|
| Nebius Compute Cloud   | GPU-enabled VMs (e.g., `gpu-standard-v100`)     |
| Slurm Workload Manager | HPC-style resource scheduling and job control   |
| PyTorch / TensorFlow   | For model training                              |
| Kaggle CLI             | To download datasets from Kaggle                |
| Object Storage / NFS   | Dataset and model artifact sharing              |
| JupyterLab (optional)  | For dev, experimentation, and monitoring        |

---

## 🧠 Architecture Overview

+-------------------+ +-----------------+ | Login / Head | <----> | Compute Node | | Node (Slurm) | | (GPU Enabled) | +-------------------+ +-----------------+ | | SSH / Slurm CLI / Jupyter | v +------------------------+ | Nebius Object Storage | | (Kaggle Datasets) | +------------------------+