
FROM golang:1.20 AS builder
WORKDIR /app

COPY go.mod go.sum ./
RUN go mod tidy


COPY . .
RUN go build -o /app/app main.go  # Ensure the binary is built in /app/


FROM alpine:latest
WORKDIR /root/

RUN apk add --no-cache logrotate


COPY --from=builder /app/app .

RUN chmod +x /root/app


RUN mkdir -p /var/log/app


CMD ["/root/app"]
