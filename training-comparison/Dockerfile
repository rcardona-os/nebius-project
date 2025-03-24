FROM python:3.10-slim

RUN apt-get update && apt-get install -y git && \
    pip install torch torchvision

WORKDIR /app
COPY train.py .

ENTRYPOINT ["python", "train.py"]