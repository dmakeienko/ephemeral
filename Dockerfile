FROM python:3.10-alpine3.17
LABEL Owner="denys.makeienko@gmail.com"

ENV USERNAME="python"

RUN apk --no-cache update && apk upgrade \
    && addgroup -S $USERNAME && adduser -S $USERNAME -G $USERNAME

ADD --chown=$USERNAME:$USERNAME ./app /app/

USER python
WORKDIR /app

RUN pip install -r requirements.txt

EXPOSE 5000
CMD ["python", "/app/main.py"]