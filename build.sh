#!/bin/bash

listener_ip=""
listener_port=4444
serve_port=8000

# Help function
usage() {
  echo "Usage: $0 [-p PORT] [-l PORT] [-i IP]"
  echo "  -p PORT      Specify the web server port (default: 8000)"
  echo "  -l PORT      Specify the listener port (default: 4444)"
  echo "  -i IP        Specify the listener ip (required)"
  exit 1
}


# Parse options
while getopts ":i:l:p:" opt; do
  case $opt in
    i)
      listener_ip=$OPTARG
      ;;
    l)
      listener_port=$OPTARG
      ;;
    p)
      serve_port=$OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      usage
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      usage
      ;;
  esac
done


# Check if -i option was specified
if [ -z "$listener_ip" ]; then
  echo "Error: -i IP is required."
  usage
fi

# Shift the positional arguments so that they don't interfere with getopts
shift $((OPTIND - 1))

docker build . --build-arg listener_ip=$listener_ip --build-arg listener_port=$listener_port --build-arg serve_port=$serve_port -t plugin
echo
echo "Ready to serve your plugin! Your repo url is: http://$listener_ip:$serve_port/manifest.json"
echo "add this URL to Jellyfin and refresh the Jellyfin catalog to find your plugin and install it"
echo "then run the following command in another terminal to start the listener"
echo "nc -l -p $listener_port"
echo "!!!!!!!LEAVE THIS TERMINAL OPEN!!!!!!!!!"
docker run --rm -it -p $serve_port:8000 plugin
