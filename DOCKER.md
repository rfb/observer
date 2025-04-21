# Docker

Setup:

Start docker compose. This will initiate the build.

```
docker compose up
```

After the services are started, run the following in another terminal:

Initialize the database
```
docker compose run -T --rm db mariadb -u observer --password=observer --database=observer < db/dbclean.sql
```

Run updates
```
docker compose run -it --rm web php /var/www/html/tools/cli/ob updates run
```

Setup admin user
```
docker compose run -it --rm web php /var/www/html/tools/cli/ob passwd admin
```

