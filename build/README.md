# Dockerfile for Atom
Installs atom and PlantUml inside a Java8 Docker container to allow automated testing of atom packages.
Uses a local registry based on boot2docker for CI demo purposes.

To create, tag & push the Java8 container run:
```
docker build -t mrohland/java8 -f Dockerfile.java8 .
docker tag mrohland/java8 $(boot2docker ip):5000/mrohland/java8
docker push $(boot2docker ip):5000/mrohland/java8

```
To create atom docker container which bases on the Java container run:

```
docker build -t mrohland/atom:v0.206.0 -f Dockerfile.atom .
docker tag mrohland/atom:v0.210.0 $(boot2docker ip):5000/mrohland/atom:v0.210.0
docker push $(boot2docker ip):5000/mrohland/atom:v0.210.0
```
