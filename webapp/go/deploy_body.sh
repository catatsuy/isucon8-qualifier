#!/bin/bash -x

echo "start deploy ${USER}"
GOOS=linux go build -o torb src/torb/app.go
for server in isu01 isu02 isu03; do
  ssh -t $server "sudo systemctl stop torb.go"
  scp ./torb $server:/home/isucon/torb/webapp/go/.
  rsync -av ./views/ $server:/home/isucon/torb/webapp/go/views/
  ssh -t $server "sudo systemctl start torb.go"
done

echo "finish deploy ${USER}"
