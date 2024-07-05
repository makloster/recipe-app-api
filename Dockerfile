FROM python:3.9-alpine3.13
LABEL maintainer="makloster"

# output from python printed directly to console
ENV PYTHONUNBUFFERED 1

#copy these files to the container
COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt ./tmp/requirements.dev.txt
COPY ./app /app
WORKDIR /app
EXPOSE 8000

ARG DEV=false
#runs a single command for a single layer for the image
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    #shell code that runs the code if in DEV mode
    if [ $DEV = "true" ]; \
      then /py/bin/pip install -r /tmp/requirements.dev.txt ; \
    fi && \
    rm -rf /tmp && \
    adduser \
        --disabled-password \
        --no-create-home \
        django-user

ENV PATH="/py/bin:$PATH"

USER django-user