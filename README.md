# s3cmd
A simple s3cmd S3 client installed on the Alpine:latest container

Useful with any S3 compatible object storage system.

## Basic usage

```sh
$ docker run -v $(pwd):/s3 -v $HOME/.s3:/root d3fk/s3cmd sync . s3://bucket-name
```
The first volume is using your current directory as workdir and the second volume is used for the configuration of your S3 connection.

## s3cmd settings

It basically uses the .s3cfg configuration file. If you are already using s3cmd locally the previous docker command will use the .s3cfg file you already have at ``$HOME/.s3/.s3cfg``. In case you are not using s3cmd locally or don't want to use your local .s3cfg settings, you can use the s3cmd client to help you to generate your .s3cfg config file by using the following command.

```sh
mkdir .s3
docker run --rm -ti -v $(pwd):/s3 -v $(pwd)/.s3:/root d3fk/s3cmd --configure
```
A blank .s3cfg file is also provided in the .s3 directory as a template if you wish to configure it by yourself from scratch.

### s3cmd and encryption
s3cmd enable you with encryption during transfert with SSL if defined in the config file or if the option in metionned in the command line.
s3cmd also enable you with encryption at REST with server-side encryption by using the flag --server-side-encryption (e.g: you can specify the KMS key to use on the server), or client side encryption by using the flag -e or --encrypt. These options can also be defined in the .s3cfg config file.

### `s3cmd` documentation

See [here](http://s3tools.org/usage) for the documentation.


## Automatic Periodic Backups with Kubernetes

This container was made to be used within a K8s CRONJOB.
You can use the provided YAML file named backup-cronjob.yaml as a template for your CRONJOB.

### s3cmd & mysql backups

In case you are interested in storing your database dumps into a S3 compatible object storage you'd probably prefer to use d3fk/mysql-s3-backup also based on Alpine distrib and containing a mysql client in addition to the s3cmd tool.
