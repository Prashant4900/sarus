---
sidebar_position: 4
---

# Deployment Guide

Sarus is a **Dart server framework** designed for production-ready backend applications.

It provides a simple command to build your app and generate all necessary files for Docker deployment.

## Build your server

Create a **production build**:

```bash
sarus build
```

This will:
- Generate a `build` folder containing your server code.
- Create a `Dockerfile` for easy deployment.
- Compile your Dart server to a native executable

## Run locally (development mode)

Test your production build locally:

```bash
sarus dev
```

The `build` folder is now served at [http://localhost:8080/](http://localhost:8080/).

## Deploy your server

Once you have the `build/` directory, you can test and deploy with Docker:

### Testing Locally with Docker

```bash
cd build
docker-compose up --build
```

