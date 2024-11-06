FROM python:3.11

ENV PYTHONUNBUFFERED=1

ARG DEV=false

COPY ./requirements.txt /tmp/requirements.txt

COPY ./app /app

WORKDIR /app

EXPOSE 8000

# Install postgresql-client
RUN apt-get update && \
    apt-get install -y --no-install-recommends postgresql-client && \
    rm -rf /var/lib/apt/lists/*

# Install requirements
RUN pip install -r /tmp/requirements.txt

# Remove non-needed files in the container
RUN rm -rf /tmp

# Adding user (By default is ROOT - less secure)
RUN adduser --disabled-password --no-create-home django-user

USER django-user
