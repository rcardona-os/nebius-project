#### - Create the model
```bash
$ cat train.py
```

```text
# train.py
import torch
from torchvision import datasets, transforms
from torch import nn, optim
import time

device = torch.device("cuda" if torch.cuda.is_available() else "cpu")

train_loader = torch.utils.data.DataLoader(
    datasets.MNIST('/tmp/data', train=True, download=True,
                   transform=transforms.ToTensor()),
    batch_size=64, shuffle=True)

model = nn.Sequential(
    nn.Flatten(),
    nn.Linear(28*28, 128),
    nn.ReLU(),
    nn.Linear(128, 10)
).to(device)

optimizer = optim.SGD(model.parameters(), lr=0.01)
loss_fn = nn.CrossEntropyLoss()

for epoch in range(5):  # Repeat to stretch training time
    total_loss = 0
    for batch_idx, (data, target) in enumerate(train_loader):
        data, target = data.to(device), target.to(device)
        optimizer.zero_grad()
        output = model(data)
        loss = loss_fn(output, target)
        loss.backward()
        optimizer.step()
        total_loss += loss.item()

        # Introduce artificial delay per batch
        time.sleep(0.05)

    print(f"Epoch {epoch+1}, Loss: {total_loss}")
```

#### - Creating the container image
```bash
$ cat Dockerfile
```

```text
FROM python:3.10-slim

RUN apt-get update && apt-get install -y git && \
    pip install torch torchvision

WORKDIR /app
COPY train.py .

ENTRYPOINT ["python", "train.py"]
```