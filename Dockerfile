FROM ubuntu:latest

WORKDIR /mnt

COPY ./mapcrafter.conf /mnt/mapcrafter.conf

RUN apt-get update \

# Install tools needed to build 
&& apt-get install -y \
	apt-transport-https \
	lsb-release \
	python \
	wget \

# Add sources
&& echo "deb http://packages.mapcrafter.org/ubuntu $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/mapcrafter.list \
&& wget -O /etc/apt/trusted.gpg.d/mapcrafter.gpg http://packages.mapcrafter.org/ubuntu/keyring.gpg \

# Install mapcrafter
&& apt-get update \
&& apt-get install -y --no-install-recommends mapcrafter \

# Remove intermediate packages
&& apt-get purge -y \
	apt-transport-https \
	lsb-release \
	python \
	wget \
&& apt-get autoremove -y \

# Cleanup APT when done.
&& apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

CMD mapcrafter_markers -c mapcrafter.conf && mapcrafter -c mapcrafter.conf
