# Using Python 3.11 slim as base (Debian Bookworm)
FROM python:3.11-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV DISPLAY=:99

# Install system dependencies - using playwright's --with-deps handles most of these
RUN apt-get update && apt-get install -y --no-install-recommends \
    xvfb \
    curl \
    procps \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy requirements and install
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install --no-cache-dir playwright

# Install Playwright Chromium WITH all system dependencies automatically
RUN playwright install --with-deps chromium

# Copy the application code
COPY . .

# Ensure start.sh is executable and fix line endings
RUN sed -i 's/\r//' start.sh && chmod +x start.sh

# Expose Streamlit port
EXPOSE 8503

# Start the application via the dedicated script
CMD ["bash", "start.sh"]
