# Stage 1: Build the application
FROM golang:alpine3.14 AS build

# Set the working directory to /app
WORKDIR /app

# Copy the Go source code into the container
COPY . .

# Download the dependencies
RUN go mod download

# Build the application with optimized flags
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags "-s -w" -o main main.go

# Stage 2: Create a production-ready image
FROM alpine:3.14

# Set the working directory to /app
WORKDIR /app

# Copy the binary from the build stage
COPY --from=build /app/main .

# Expose the port
EXPOSE 8080

# Run the command to start the application
CMD ["./main"]