FROM python:3.9

ENV PYTHONUNBUFFERED=1

ARG DEV=false

COPY ./requirements.txt /tmp/requirements.txt

# In case we want to use Flake8 for linting
COPY ./requirements.dev.txt /tmp/requirements.dev.txt

COPY ./app /app

WORKDIR /app

EXPOSE 8000

# Create venv (Adding another layer of isolation using a venv in a docker container)
RUN python -m venv /py 

# Upgrade pip
RUN /py/bin/pip install --upgrade pip

# Install requirements
RUN /py/bin/pip install -r /tmp/requirements.txt

# Only using flake8 if DEV purposes
RUN if [ $DEV = "true" ]; then /py/bin/pip install -r /tmp/requirements.dev.txt ; fi

# Remove non-needed files in the container
RUN rm -rf /tmp

# Adding user (By default is ROOT - less secure)
RUN adduser --disabled-password --no-create-home \django-user

# For python commands
ENV PATH="/py/bin:$PATH"

USER django-user