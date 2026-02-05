FROM python:3.14.2
RUN apt-get update && apt-get install -yq socat
WORKDIR /jail
COPY --chmod=444 flag.txt .
WORKDIR /jail/app
COPY --chmod=444 jail.py .

USER nobody:nogroup

CMD ["socat", "TCP-L:5000,fork,reuseaddr", "EXEC:'python jail.py',stderr"]
