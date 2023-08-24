FROM  python:3.11-alpine3.12
LABEL maintainers="git-GITGOODMAN"
ENV PYTHONBUFFERED 1
COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt

COPY ./app /app
WORKDIR /app
EXPOSE 8000
ARG DEV=false

RUN python -m venv /py &&\
/py/bin/pip install --upgrade pip &&\
 if [ $DEV = "true" ]; \
    then /py/bin/pip install -r /tmp/requirements.dev.txt; \
 fi && \ 
/py/bin/pip install -r /tmp/requirements.txt &&\
rm -rf /tmp &&\
adduser \
 --disabled-pasword \
 --no-create-home\
 django-user

ENV PATH="/py/bin:$PATH"
USER django-user
