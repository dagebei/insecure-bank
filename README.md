# Insecure Bank

## Building

```
sudo apt install -y openjdk-11-jdk
sudo apt install -y maven
```

Now clone this repository.

```
cd insecure-bank
mvn clean package
```

## Running

```
sudo apt install -y docker.io
sudo docker build -t wildfly .
sudo docker run --rm -it -p 8080:8080 wildfly
```

You can then access the bank application here: http://localhost:8080/

## Login credentials

See the file [src/main/resources/db/dataload.sql](src/main/resources/db/dataload.sql) for all example accounts. Here is one:

- username: john@example.com
- password: test
