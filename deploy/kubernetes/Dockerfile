FROM ubuntu:22.04
RUN apt-get update && apt-get install -y gcc nasm libssl-dev golang-go
COPY ../core /app/core
COPY ./api /app/api
RUN cd /app/core && make
RUN cd /app/api && go build -o server
EXPOSE 8080
CMD ["/app/api/server"]
