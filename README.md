# PgHero Solo

This repository is a containerized, standalone instance of the excellent [PgHero engine](https://github.com/ankane/pghero).  It allows you to pass a `DATABASE_URL` environment variable to run PgHero within Docker against your database without having to mount this inside your Rails application.  It allows all the benefits of PgHero while allowing you to run a separate application instance safely behind your firewall without fear of accidently exposing it through your production Rails app.

This strategy is used at [Yammer](https://www.yammer.com) to run PgHero against each of our different shards.

This repository has an [automated build](https://registry.hub.docker.com/u/bmorton/pghero/) on the public Docker hub.  To demo this and run it on OS X with boot2docker installed, you can connect to a Homebrew-installed Postgres instance like this:

```
docker run -ti -e DATABASE_URL=postgres://user@10.0.2.2:5432/myapp_development -p 8080:8080 bmorton/pghero
```
