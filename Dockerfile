FROM golang:1.12-alpine AS builder

WORKDIR /discord_bot
COPY ./src .

RUN CGO_ENABLED=0 GOOS=linux go build -v -o helloworld

FROM alpine:3.9.4
RUN apk add --no-cache ca-certificates

COPY --from=builder /discord_bot /discord_bot

CMD ["/discord_bot"]