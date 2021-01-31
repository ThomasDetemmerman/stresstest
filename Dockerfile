FROM alpine

ENV URL="http://localhost:8080/ondemandfilter"
ENV USERS=50

COPY ./src /src

RUN apk update && apk add bash && apk add curl && chmod -R 777 /src

ENTRYPOINT [ "/bin/bash","/src/curl.sh" ] 