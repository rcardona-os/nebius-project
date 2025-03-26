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

Use Terraform to provision resources:

```hcl
resource "yandex_compute_instance" "slurm_head" {
  name = "slurm-head"
  ...
}

resource "yandex_compute_instance" "slurm_compute" {
  count = 2
  name  = "slurm-compute-${count.index}"
  ...
}
```

Run Terraform:
```bash
terraform init
terraform apply
```

---

### 2. ⚙️ Install Slurm (Multi-node)

#### On Head Node:
```bash
sudo apt update && sudo apt install slurmctld slurmdbd munge -y
```

#### On Compute Node(s):
```bash
sudo apt update && sudo apt install slurmd munge -y
```

#### Sync Configuration

Use this sample `slurm.conf`:
```bash
ControlMachine=slurm-head
NodeName=slurm-compute-[0-1] CPUs=8 Gres=gpu:1 State=UNKNOWN
PartitionName=gpu Nodes=ALL Default=YES MaxTime=INFINITE State=UP
```

Distribute `munge.key` across all nodes and start services:
```bash
sudo systemctl enable munge slurmctld slurmd
sudo systemctl start munge slurmctld slurmd
```

---

### 3. 🧠 Install ML Environment

```bash
sudo apt install python3-pip -y
pip3 install torch torchvision torchaudio kaggle
sudo apt install nvidia-cuda-toolkit -y
```

---

### 4. 🐍 Download Dataset (Kaggle)

1. Add `kaggle.json`:
```bash
mkdir ~/.kaggle
cp kaggle.json ~/.kaggle/
chmod 600 ~/.kaggle/kaggle.json
```

2. Download dataset:
```bash
kaggle competitions download -c cassava-leaf-disease-classification
```

---

### 5. 🧾 Slurm Job Script

`train.sh`
```bash
#!/bin/bash
#SBATCH --job-name=ml-train
#SBATCH --partition=gpu
#SBATCH --gres=gpu:1
#SBATCH --time=02:00:00
#SBATCH --output=output_%j.log

module load python
python3 train_model.py
```

Submit:
```bash
sbatch train.sh
```

---

### 6. ✍️ Model Training Script

`train_model.py`
```python
import torch
import torchvision
import torchvision.transforms as transforms
from torchvision import models
from torch import nn, optim

# Simple device check
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
print("Using device:", device)

# Dummy model setup (expand as needed)
model = models.resnet18(pretrained=False)
model.fc = nn.Linear(model.fc.in_features, 5)  # For 5 classes
model = model.to(device)

# Example input
dummy_input = torch.randn(4, 3, 224, 224).to(device)
output = model(dummy_input)
print("Output shape:", output.shape)
```

---

## 📁 Storage Considerations

| Option | When to Use |
|--------|-------------|
| NFS    | Simple and fast for shared filesystem between nodes |
| Nebius Object Storage | For scalable, durable blob storage (datasets/models) |
| Local disk | For temporary, high-speed storage |

---

## 📦 GitHub Repo Structure

```
slurm-gpu-ml-lab/
├── terraform/               # Infrastructure as code
│   └── main.tf
├── scripts/
│   ├── train.sh             # Slurm job script
│   └── setup.sh             # Bash setup script (install Slurm, Python, etc)
├── src/
│   └── train_model.py       # ML model training
├── data/                    # Place for datasets (optional)
├── README.md
└── .kaggle/kaggle.json      # Kaggle API credentials
```

---

## 🧪 Optional Enhancements

- ✅ Install JupyterLab on head node for interactive dev
- ✅ Add Prometheus/Grafana for GPU metrics
- ✅ Run multiple jobs to test scheduling
- ✅ Test multi-GPU training
- ✅ Integrate with OpenShift AI later

---

## 🧭 Next Steps

Choose your preferences:

1. 🧮 **Single-node or Multi-node Slurm cluster?**
2. 🐍 **PyTorch or TensorFlow?**
3. 📦 **Object Storage or NFS?**
4. 📜 **Use automation (Terraform / Bash / Ansible)**
5. 💻 **Use SSH-based or Jupyter-based interface**

Let’s go build it! 🚀