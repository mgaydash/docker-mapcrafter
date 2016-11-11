docker rm mapcrafter
docker run \
	-d \
	-v /mnt/minecraft/world:/mnt/world \
	-v /home/ubuntu/www:/mnt/www \
	--name mapcrafter \
	mapcrafter:3.0.0 mapcrafter -c mapcrafter.conf
