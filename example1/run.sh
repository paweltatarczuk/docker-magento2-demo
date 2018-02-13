# Create app dir
mkdir app

# Create networks
docker network create demo--backend
docker network create demo--database
docker network create demo--cache
docker network create demo--frontend

# Create MySQL
docker create \
  --name          demo--mysql \
  --network       demo--database \
  --network-alias db \
  -e MYSQL_DATABASE=magento -e MYSQL_USER=magento \
  -e MYSQL_PASSWORD=secret -e MYSQL_ROOT_PASSWORD=secret \
  mysql:5.7

# Create Redis
docker create \
  --name          demo--redis \
  --network       demo--cache \
  --network-alias redis \
  redis:4

# Create PHP-FPM
docker build -t demo--php-fpm - < ./php-fpm.Dockerfile
docker create \
  --user          "$(id -u):$(id -g)" \
  --name          demo--php-fpm \
  --network       demo--backend \
  --network-alias php-fpm \
  --volume       "$(pwd)/app:/app" \
  demo--php-fpm
docker network connect demo--cache demo--php-fpm
docker network connect demo--database demo--php-fpm

# Create Nginx
docker create \
  --publish      "80:80" \
  --name          demo--nginx \
  --network       demo--frontend \
  --volume       "$(pwd)/nginx.conf:/etc/nginx/conf.d/default.conf" \
  --volume       "$(pwd)/app:/app" \
  nginx
docker network connect demo--backend demo--nginx

# -------------------------------------

# Set up Magento
docker run --rm \
  --volume "$(pwd)/app:/app" \
  --volume "$HOME/.composer:/tmp" \
  --user $(id -u):$(id -g) \
  composer create-project \
    --ignore-platform-reqs \
    --repository-url=https://repo.magento.com/ \
    magento/project-community-edition \
    /app
