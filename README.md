# Simple Laravel Docker Setup

This repository contains the Docker configuration for a Laravel application, providing a complete setup for local development, and could be used for production as well. It includes services like Nginx, MySQL, PHPMyAdmin, and Redis, orchestrated with Docker Compose.

## Services

The setup includes the following services:

- **App**: PHP-FPM container for the Laravel application.
- **Nginx**: Web server for serving the Laravel application.
- **Database**: MySQL database service.
- **PHPMyAdmin**: Web interface for database management.
- **Redis**: Redis server for caching and session storage.

## Getting Started

### Prerequisites

- Docker and Docker Compose installed on your machine.
- Laravel application code in the `src` directory. If you have an existing project, you can copy your source code into the src folder.

### Setting Up 

1. **Clone the Repository**
```
git clone https://github.com/zsoro2/simple-docker-laravel.git
cd simple-docker-laravel
```

2. **Environment Variables**
- Set up your `.env` file with the necessary environment variables for MySQL.

3. **Build and Run the Containers**
```
docker-compose up -d --build
```
4. **Install Laravel on the docker container**
```
docker-compose exec app bash
composer create-project --prefer-dist laravel/laravel .
```
5. **Access Your Application**
- The Laravel application will be available at `http://localhost:8080`.
- PHPMyAdmin will be accessible at `http://localhost:8081`.

### Useful commands
```
docker-compose down # Stops and removes all running containers defined in docker-compose.yml.

docker-compose build # Builds or rebuilds all services defined in docker-compose.yml.

docker-compose build app # Specifically builds or rebuilds the 'app' service.

docker-compose up -d # Starts the containers in detached mode, running them in the background.

docker-compose exec app bash # Executes an interactive bash shell inside the running 'app' container.
```
### Database settings
The info for database connection could be found in  `.env`
```
MYSQL_DATABASE=laravel_project
MYSQL_USER=project_user
MYSQL_PASSWORD=secret
MYSQL_ROOT_PASSWORD=root_password
```
### Directory Structure
```
/
├── src/                  # Your Laravel application code
├── docker-compose/       # Docker related configurations
│   ├── nginx/            # Nginx configuration files
│   ├── php/              # PHP configuration files
│   ├── supervisor/       # Supervisor configuration files
│   └── crontab/          # Crontab files
├── .env                  # Env file for Docker configuration
├── Dockerfile            # Dockerfile for the Laravel application
└── docker-compose.yml    # Docker Compose configuration file
```

## Dockerfile

The Dockerfile sets up the PHP environment with necessary extensions and configurations required for Laravel. It includes:

- PHP 8.2-FPM as the base image.
- Installation of system dependencies and PHP extensions.
- Composer for PHP dependency management.
- Configuration for cron jobs and Supervisor.

## Customization

You can customize the Docker setup by editing the `Dockerfile` or the `docker-compose.yml` file to suit your specific requirements.

## Contributing

Feel free to fork this repository and customize it for your own Laravel projects. If you have suggestions or improvements, pull requests are welcome.