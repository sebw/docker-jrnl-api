# Jrnl API

Expose an API for [jrnl](https://jrnl.sh/).

## Installation

Build the image:

```
docker build  --tag jrnl-api:0.1 .
```

Create your container:

```
docker run -d \
    -v /your/host/directory:/.local/share/jrnl 
    -v /etc/localtime:/etc/localtime:ro
    -p 5000:5000 
    --name journal
    jrnl-api:0.1
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

## Known limitations / Use at your own risk

- limited to posting new entries
- entries can not contain parenthesis and probably other weird characters. It doesn't fail if a character is not accepted. I still have to take care of input sanitization.
- currently, entries are with the "now" timestamp, it's not possible to add an entry for yesterday
- no TLS, I leave it to Traefik or similar
- no authentication, ditto
- journal.txt is on your Docker host, which prevents you from using jrnl CLI if your Docker host is not your workstation (something like sshfs would then be needed)
