FROM python:3.6.1-slim

# Set the working dir to /crosscheck
WORKDIR /crosscheck

# Copy source files
ADD . /crosscheck

# Install requirements
RUN pip install Flask

# Expose port 5000
EXPOSE 5000

# Run
CMD ["python", "Website/app.py"]

