# Use the official Python base image
FROM python:3.10.12-slim

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file
COPY requirements.txt .

# Install gunicorn
RUN pip install gunicorn

# Install the Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the Flask application code
COPY . .

# Remove requirements to save space
RUN rm requirements.txt

# Expose the port on which the Gunicorn server will run
EXPOSE 8000

# Set the environment variables for Gunicorn
ENV BIND_HOST=0.0.0.0
ENV BIND_PORT=8000
ENV WORKERS=1
ENV THREADS=12

# Run the Gunicorn server
CMD gunicorn --bind $BIND_HOST:$BIND_PORT --workers $WORKERS --threads $THREADS app:app
