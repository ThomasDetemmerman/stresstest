#!/bin/bash
exec 3<> /tmp/foo
sequence () {
i=0
while true
    do
        i=$((i+1))
        curl -s -F files=@src/filters.base64.txt -F files=@src/content.txt $URL > /dev/null
        echo "test executed $1.$i" #dit wordt ge-echo-t naar de meegegeven file descriptor (niet naar stdin (file descriptor 1))
    done
}

echo "start"
fds=()
for (( i=0; i<$USERS; i++ )); do
  exec {fd}> >(sequence $i) #neem de laats beschikbare file descriptor en start de functie in een subshell
  fds+=( $fd )				#sla de file descriptor op in een array
done

echo "reading"
while true; do
  for fd in "${fds[@]}"; do #itereer over de array
    echo  >&$fd				#lees van de file descriptor
  done
done