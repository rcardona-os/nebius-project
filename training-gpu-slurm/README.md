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

```
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
```

---

## 📦 Suggested Datasets (Kaggle)

| Dataset | Type | Link |
|--------|------|------|
| Cassava Leaf Disease | Image Classification | [🔗 Kaggle](https://www.kaggle.com/c/cassava-leaf-disease-classification) |
| House Prices | Regression | [🔗 Kaggle](https://www.kaggle.com/competitions/house-prices-advanced-regression-techniques) |
| Titanic Challenge | Binary Classification | [🔗 Kaggle](https://www.kaggle.com/c/titanic) |
| Dog Breed Identification | Deep CNN | [🔗 Kaggle](https://www.kaggle.com/c/dog-breed-identification) |

---

## 🚀 Lab Setup Procedure

### 1. 🔧 Provision Infrastructure

- Create **Head Node** VM (Ubuntu 22.04)
- Create **Compute Node(s)** with GPU (e.g. `gpu-standard-v100`)
- Ensure nodes are on the same VPC/network

### 2. ⚙️ Install Slurm

#### On Head Node:
```bash
sudo apt update && sudo apt install slurmctld slurmdbd -y
```

#### On Compute Node(s):
```bash
sudo apt update && sudo apt install slurmd -y
```

#### Configure Slurm:
- Copy or create `/etc/slurm/slurm.conf` on all nodes
- Sample `slurm.conf` should include definitions for control and compute nodes

Enable and start services:
```bash
sudo systemctl enable slurmctld slurmd
sudo systemctl start slurmctld slurmd
```

### 3. 🧠 Install ML Environment

```bash
sudo apt install python3-pip -y
pip3 install torch torchvision torchaudio kaggle
```

Install CUDA toolkit:
```bash
sudo apt install nvidia-cuda-toolkit -y
```

### 4. 🐍 Download Dataset (Kaggle)

1. Place your `kaggle.json` in the home directory:
```bash
mkdir ~/.kaggle
cp kaggle.json ~/.kaggle/
chmod 600 ~/.kaggle/kaggle.json
```

2. Download a dataset (example: Cassava Leaf Disease):
```bash
kaggle competitions download -c cassava-leaf-disease-classification
```

### 5. 🧾 Write Slurm Job Script

Create `train.sh`:
```bash
#!/bin/bash
#SBATCH --job-name=ml-train
#SBATCH --partition=gpu
#SBATCH --gres=gpu:1
#SBATCH --time=01:00:00
#SBATCH --output=output_%j.log

python3 train_model.py
```

Submit the job:
```bash
sbatch train.sh
```

### 6. ✍️ Write Your Model Training Script

Create `train_model.py` (example):
```python
import torch
import torchvision
print("Torch Version:", torch.__version__)
print("CUDA Available:", torch.cuda.is_available())
```

---

## 📁 Storage Considerations

| Option | When to Use |
|--------|-------------|
| NFS    | Simple and fast for shared filesystem between nodes |
| Nebius Object Storage | For scalable, durable blob storage (datasets/models) |
| Local disk | For temporary, high-speed storage |

---

## 🧪 Optional Enhancements

- ✅ Install JupyterLab on head node for interactive development
- ✅ Add Prometheus/Grafana to monitor GPU usage
- ✅ Test job queueing and multi-user workflows
- ✅ Add Docker/Podman to containerize training jobs
- ✅ Move to OpenShift AI with Slurm backend later

---

## 🧭 Next Steps

Choose your preferences:

1. 🧮 **Single-node or Multi-node Slurm cluster?**
2. 🐍 **PyTorch or TensorFlow?**
3. 📦 **Object Storage or NFS?**
4. 📜 **Do you want automation (Terraform / Bash / Ansible)?**
5. 💻 **SSH-based or Jupyter-based interface?**

Let’s go build it! 🚀
