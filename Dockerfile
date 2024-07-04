FROM python:3.9-alpine3.13
LABEL maintainer="makloster"

# output from python printed directly to console
ENV PYTHONBUFFERED 1

#copy these files to the container
COPY ./requirements.txt /tmp/requirements.txt
COPY ./app /app
WORKDIR /app
EXPOSE 8000

#runs a single command for a single layer for the image
RUN python m venv /py && \
  /py/bin/pip install --upgrade pip && \
  /py/bin/pip install -r /tmp/requirements.txt && \
  rm -rf /tmp && \
  adduser \
    --disabled-password \
    --no-create-home \
    django-user

ENV PATH="/py/bin:$PATH"

USER django-user