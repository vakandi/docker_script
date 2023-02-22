curl -s localhost:4040/api/tunnels | jq -r .tunnels[0].public_url

or

curl -s localhost:4040/api/tunnels | jq -r .tunnels\[0\].public_ur
l

or

curl -s localhost:4040/api/tunnels | jq -r ".tunnels[0].public_url
"

or

curl http://127.0.0.1:4040/api/tunnels


