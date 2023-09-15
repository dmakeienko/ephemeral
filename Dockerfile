FROM python:3.10-alpine3.17 as python_base
LABEL Owner="denys.makeienko@gmail.com"

ENV USERNAME="python"

#Update image and add non-root user
RUN apk --no-cache update && apk upgrade \
    && addgroup -S $USERNAME && adduser -S $USERNAME -G $USERNAME
USER python


FROM python_base as app

ADD --chown=$USERNAME:$USERNAME ./app /app/
WORKDIR /app

RUN pip install -r requirements.txt

EXPOSE 5000
CMD ["python", "/app/main.py"]