FROM composer

ARG COMPOSER_AUTH
ARG MAGENTO_VERSION

RUN composer create-project \
    --ignore-platform-reqs \
    --repository-url=https://repo.magento.com/ \
    magento/project-community-edition:$MAGENTO_VERSION \
    /app \
    && chown 1000:1000 -R /app