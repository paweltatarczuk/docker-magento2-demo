# Docker - Magento2 usage demonstration

This is a demonstration of docker for Magento 2 uses.

*Use at own risk.*

## Example 1

This example shows how to use Docker CLI to set up Magento 2 enviornment.

1. Creates 'backend', 'database', 'cache' and 'frontend' networks
2. Creates 'mysql', 'redis', 'php-fpm' and 'nginx' containers
3. Fetches Magento 2 integrator installation in 'app' directory
4. Starts all containers

To run this example execute:

```
$ cd example1
$ sh get-magento.sh
$ sh run.sh
```

After all commands finish visit: http://localhost

To clean up after this example execute:

```
$ docker stop demo--mysql demo--redis demo--php-fpm demo--nginx
$ docker rm -v demo--mysql demo--redis demo--php-fpm demo--nginx
$ docker network rm demo--backend demo--database demo--cache demo--frontend
$ rm -r app
```

## Example 2

This example shows how to use Docker Compose to set up Magento 2 environment.

To run this example execute:

```
$ cd example2
$ sh get-magento.sh
$ docker-compose up
```

To clean up after this example:

```
$ docker-compose down -v
$ docker-compose rmi example2_php-fpm
$ rm -r app
```

## Example 3

This example extends example 2 with image with Magento 2 and shows how to use it.

To run this example execute:

```
$ cd example3
$ docker-compose up
```

To clean up after this example:

```
$ docker-compose down -v
$ docker-compose rmi example3_php-fpm example3_magento
```
