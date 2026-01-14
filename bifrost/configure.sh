#!/bin/bash

# Define config path
CONFIG_PATH="/config/bifrost/config.yaml"

# Helper function to read options
# Home Assistant uses bashio for easier option handling, but we stick to raw jq/options.json 
# or use bashio if available in the base image. 
# Since we are on a generic debian image, we probably don't have bashio installed unless we install it or the base image has it.
# The user's Dockerfile showed `FROM rust...` then `FROM debian...`. 
# BUT `build.yaml` showed `build_from: ghcr.io/chrivers/bifrost:master...`.
# Usually standard HA add-ons use an Alpine or Debian base that INCLUDES bashio.
# However, this seems to be a custom add-on wrapping an existing image.
# We will use vanilla jq.

OPTIONS_FILE="/data/options.json"

log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $1"
}

if [ -f "$OPTIONS_FILE" ]; then
    BRIDGE_MAC=$(jq -r '.bridge_mac // empty' $OPTIONS_FILE)
    BRIDGE_IP=$(jq -r '.bridge_ip // empty' $OPTIONS_FILE)
    MQTT_HOST=$(jq -r '.mqtt_host // "core-mosquitto"' $OPTIONS_FILE)
    Z2M_HOST=$(jq -r '.z2m_host // "core-zigbee2mqtt"' $OPTIONS_FILE)
    Z2M_PORT=$(jq -r '.z2m_port // 1883' $OPTIONS_FILE)
    Z2M_TOPIC=$(jq -r '.z2m_topic // "zigbee2mqtt"' $OPTIONS_FILE)
    OVERWRITE=$(jq -r '.overwrite_config // false' $OPTIONS_FILE)
else
    log "Options file not found, using defaults"
    MQTT_HOST="core-mosquitto"
    Z2M_HOST="core-zigbee2mqtt"
    Z2M_PORT=1883
    Z2M_TOPIC="zigbee2mqtt"
    OVERWRITE="false"
fi

if [ -f "$CONFIG_PATH" ] && [ "$OVERWRITE" != "true" ]; then
    log "Config file exists and overwrite is disabled. Skipping generation."
    exit 0
fi

log "Generating $CONFIG_PATH..."

# Detect IP if not provided
if [ -z "$BRIDGE_IP" ]; then
    # Try getting IP from valid interfaces, excluding loopback
    BRIDGE_IP=$(ip -4 addr show | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | grep -v "127.0.0.1" | head -n 1)
    if [ -z "$BRIDGE_IP" ]; then
        log "Could not detect IP address. Defaulting to 127.0.0.1"
        BRIDGE_IP="127.0.0.1"
    fi
fi

# Generate Random MAC if not provided
if [ -z "$BRIDGE_MAC" ]; then
    # Generate a random MAC address
    BRIDGE_MAC=$(printf '00:11:%02X:%02X:%02X:%02X\n' $[RANDOM%256] $[RANDOM%256] $[RANDOM%256] $[RANDOM%256])
    log "Generated random MAC: $BRIDGE_MAC"
fi

# Detect Gateway
GATEWAY_IP=$(ip route | grep default | awk '{print $3}' | head -n 1)
if [ -z "$GATEWAY_IP" ]; then
    GATEWAY_IP="127.0.0.1"
fi

cat <<EOF > "$CONFIG_PATH"
bridge:
  name: Bifrost Bridge
  mac: "$BRIDGE_MAC"
  ipaddress: "$BRIDGE_IP"
  netmask: 255.255.255.0
  gateway: "$GATEWAY_IP"
  timezone: America/New_York


z2m:
  server1:
    # Bifrost uses the Z2M Websocket to read states
    # Ensure port 8080 is open in Z2M config
    url: ws://$Z2M_HOST:8080 
EOF

log "Configuration generated at $CONFIG_PATH"
