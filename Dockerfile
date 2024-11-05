# Stage 1: Build the application
FROM golang:1.22.5-alpine AS build

# Set the working directory to /app
WORKDIR /app

# Copy the Go source code into the container
COPY . .

RUN go mod init

# Run go mod tidy to clean up the dependencies
RUN go mod tidy

# Download the dependencies
RUN go mod download

# Build the application
RUN go build -o main main.go

# Stage 2: Create a production-ready image
FROM alpine:latest

# Set the working directory to /app
WORKDIR /app

# Copy the binary from the build stage
COPY --from=build /app/main .

# Expose the port
EXPOSE 8080

# Run the command to start the application
CMD ["./main"]