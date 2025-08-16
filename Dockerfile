FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install --no-cache-dir \
    torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu

RUN pip install --no-cache-dir \
    pandas \
    numpy \
    scikit-learn \
    scipy \
    jupyter \
    matplotlib \
    seaborn

# Copy project files
COPY . .

# Create tmp directory for model outputs
RUN mkdir -p tmp

# Expose Jupyter port
EXPOSE 8888

# Default command to run Jupyter
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''", "--NotebookApp.password=''"]