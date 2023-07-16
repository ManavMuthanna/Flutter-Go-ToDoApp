# Start with the official Go image
FROM golang:latest

# Set the working directory inside the container
WORKDIR /app

# Copy the Go mod and sum files to the working directory
COPY go.mod go.sum ./

# Download and cache the Go modules
RUN go mod download

# Copy the source code to the working directory
COPY . .

# Build the Go application with additional build options
RUN CGO_ENABLED=0 GOOS=linux go build -o main .

# Set the binary permissions
RUN chmod +x main

# Expose the port on which the application will run
EXPOSE 3000

# Run the compiled binary
CMD ["./main"]
