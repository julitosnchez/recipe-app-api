FROM python:3.11

ENV PYTHONUNBUFFERED=1

COPY ./requirements.txt /tmp/requirements.txt

COPY ./app /app

WORKDIR /app

EXPOSE 8000

# Create venv (Adding another layer of isolation using a venv in a docker container)
RUN python -m venv /py 

# Upgrade pip
RUN /py/bin/pip install --upgrade pip

# Install requirements
RUN /py/bin/pip install -r /tmp/requirements.txt

# Remove non-needed files in the container
RUN rm -rf /tmp

# Adding user (By default is ROOT - less secure)
RUN adduser --disabled-password --no-create-home \django-user

# For python commands
ENV PATH="/py/bin:$PATH"

USER django-user