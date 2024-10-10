# Client
# CLIENT ID MUST BE 3 OR GREATER IF 1 CLIENT ALREADY EXISTS
# basically add take the existing clients count and add 2
# 1 client already exists
# 1 + 2 = 3

client_id=3
wg genkey | tee /etc/wireguard/client/priv$client_id.key | wg pubkey | tee /etc/wireguard/client/pub$client_id.key
client_priv_key=$(cat /etc/wireguard/client/priv$client_id.key)
client_pub_key=$(cat /etc/wireguard/client/pub$client_id.key)

server_pub_key=(cat /etc/wireguard/server_pub.key)

echo "[Interface]
PrivateKey = $client_priv_key
Address = 10.0.0.$client_id/24

[Peer]
PublicKey = $server_pub_key
Endpoint = servername_or_ip:51820
AllowedIPs = 0.0.0.0/0

" > /etc/wireguard/client/wg0-$client_id.conf

wg set wg0 peer $client_pub_key allowed-ips 10.0.0.$client_id
