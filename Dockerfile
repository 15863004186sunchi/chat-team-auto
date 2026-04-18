# Using Python 3.11 slim as base
FROM python:3.11-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV DISPLAY=:99

# Install system dependencies for Chromium and Playwright
RUN apt-get update && apt-get install -y --no-install-recommends \
    xvfb \
    wget \
    curl \
    unzip \
    libnss3 \
    libatk-bridge2.0-0 \
    libdrm2 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    libgbm1 \
    libpango-1.0-0 \
    libcairo2 \
    libasound2 \
    libatspi2.0-0 \
    libcups2 \
    libxkbcommon0 \
    libgtk-3-0 \
    fonts-liberation \
    procps \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy requirements and install
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install --no-cache-dir playwright

# Install Playwright Chromium
RUN playwright install chromium

# Copy the rest of the application
COPY . .

# Expose Streamlit port
EXPOSE 8503

# Create a startup script to handle Xvfb and Streamlit
RUN echo '#!/bin/bash\nXvfb :99 -screen 0 1280x720x24 -ac -nolisten tcp &\nexec streamlit run ui.py --server.port 8503 --server.address 0.0.0.0' > /app/start.sh
RUN chmod +x /app/start.sh

# Start the application
CMD ["/app/start.sh"]
