# Dockerfile for Atom
Installs atom and PlantUml inside a Java8 Docker container to allow automated testing of atom packages.
To create the Java8 container run:
* docker build -t mrohland/java8 -f Dockerfile.java8 .
To create docker container which bases on the Jave container run:
* docker build -t mrohland/atom:v0.206.0 -f Dockerfile.atom .
