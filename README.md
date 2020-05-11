# Jrnl API

Expose an API for [jrnl](https://jrnl.sh/).

## Installation

Build the image:

```
docker build  --tag jrnl-api:0.1 .
```

Create your container:

```
`docker run -d \
    -v /your/host/directory:/.local/share/jrnl 
    -v /etc/localtime:/etc/localtime:ro
    -p 5000:5000 
    --name journal
    jrnl-api:0.1`
```

## Usage

Make an API call:

```
curl -H "Content-Type: application/json" --data '{"msg": "Hello World"}' http://journal:5000/post
```

```
$ cat /your/host/directory/journal.txt

[2020-05-08 19:05] Hello World
```

## Possible integrations

- [Telegram Bot](https://core.telegram.org/bots) and [NodeRED](https://nodered.org/) to publish new entries from the Telegram app (see nodered.json for an example)

## Known limitations

- limited to posting new entries
- currently, entries are with the "now" timestamp, it's not possible to add an entry for yesterday
- no authentication, I leave it to Traefik or similar
- journal.txt is on your Docker host, which prevents you from using jrnl CLI if your Docker host is not your workstation (something like sshfs would then be needed)
