# How to run this lab 
- clone the repository 
- run it with docker compose : `docker compose up -d`
- when all container are up and running execute : `docker exec -it proxy /start.sh` and `docker exec -it app /start.sh` to run the wazuh agent on proxy and the webapp. 