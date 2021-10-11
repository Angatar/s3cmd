![Docker Pulls](https://img.shields.io/docker/pulls/d3fk/s3cmd) ![Docker Cloud Automated build](https://img.shields.io/docker/cloud/automated/d3fk/s3cmd) ![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/d3fk/s3cmd) ![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/d3fk/s3cmd) ![Docker Stars](https://img.shields.io/docker/stars/d3fk/s3cmd) [![GitHub license](https://img.shields.io/github/license/Naereen/StrapDown.js.svg)](https://github.com/Angatar/s3cmd/blob/master/LICENSE)
# s3cmd (Angatar> d3fk/s3cmd)
A simple s3cmd S3 client installed on the Alpine:latest container

Useful with any S3 compatible object storage system.

## Docker image

pre-build from Docker hub with "automated build" option.

image name **d3fk/s3cmd**

`docker pull d3fk/s3cmd`

Docker hub repository: https://hub.docker.com/r/d3fk/s3cmd/

[![DockerHub Badge](https://dockeri.co/image/d3fk/s3cmd)](https://hub.docker.com/r/d3fk/s3cmd)

## Basic usage

```sh
docker run --rm -v $(pwd):/s3 -v $HOME/.s3:/root d3fk/s3cmd sync . s3://bucket-name
```
The first volume is using your current directory as workdir and the second volume is used for the configuration of your S3 connection.

## s3cmd settings

It basically uses the .s3cfg configuration file. If you are already using s3cmd locally the previous docker command will use the .s3cfg file you already have at ``$HOME/.s3/.s3cfg``. In case you are not using s3cmd locally or don't want to use your local .s3cfg settings, you can use the s3cmd client to help you to generate your .s3cfg config file by using the following command.

```sh
mkdir .s3
docker run --rm -ti -v $(pwd):/s3 -v $(pwd)/.s3:/root d3fk/s3cmd --configure
```
A blank .s3cfg file is also provided as a template in the [.s3 directory of the source repository](https://github.com/Angatar/s3cmd/tree/master/.s3), if you wish to configure it by yourself from scratch.

### s3cmd and encryption
s3cmd enables you with encryption during transfert with SSL if defined in the config file or if the option in metionned in the command line.
s3cmd also enables you with encryption at REST with server-side encryption by using the flag --server-side-encryption (e.g: you can specify the KMS key to use on the server), or client side encryption by using the flag -e or --encrypt. These options can also be defined in the .s3cfg config file.

### s3cmd complete documentation

See [here](http://s3tools.org/usage) for the documentation.


## Automatic Periodic Backups with Kubernetes

This container was created to be used within a K8s CRONJOB.
You can use the provided YAML file named s3-backup-cronjob.yaml as a template for your CRONJOB.
A configmap can easily be created from the .s3cfg config file with the following kubectl command:
```sh
Kubectl create configmap s3config --from-file $HOME/.s3
```
Then, once configured with your data volume/path and your bucket (by completing the file or defining the ENV variables: YOUR_KMS_KEY_ID, YOUR_BUCKET_NAME, NFS_SERVER, SHARED-FOLDER), the k8s CRONJOB can be created from the file:
```sh
kubectl create -f s3-backup-cronjob.yaml
```
*Nb: the option for sync `--no-check-md5` speeds up the sync process since only size will be compared but it may also miss some changed files. However this option is usefull with server side encryption since the md5 signature of the encrypted files in the bucket will be different from the non-encrypted files that you need to back up.*

### s3cmd & mysql backups

In case you are interested in storing your database dumps into a S3 compatible object storage you'd probably prefer to use [d3fk/mysql-s3-backup](https://hub.docker.com/r/d3fk/mysql-s3-backup) also based on Alpine distrib and containing a mysql client in addition to the s3cmd tool.
