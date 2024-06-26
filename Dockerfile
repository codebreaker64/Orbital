# Use the official tiangolo/uvicorn-gunicorn-fastapi image as base
FROM tiangolo/uvicorn-gunicorn-fastapi:python3.9

# Set the working directory in the container
WORKDIR /companion

# Copy the requirements file into the container
COPY chatbot/requirements.txt /companion/

# Install the dependencies
RUN pip install -r /companion/requirements.txt

# Copy the application code into the container
COPY chatbot /companion/

# Specify the command to run the FastAPI application using uvicorn
CMD ["uvicorn", "chat:app", "--host", "0.0.0.0", "--port", "8000"]
