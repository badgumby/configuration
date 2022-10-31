# Enter pihole directory
cd /home/badgumby/pihole

# Display running docker volumes
sudo docker volume ls

# Pull latest pihole container
sudo docker pull pihole/pihole

# Stop running pihole
sudo docker stop pihole

# Remove running pihole containter
sudo docker rm -f pihole

# Deploy new pihole container using compose file
sudo docker-compose up -d