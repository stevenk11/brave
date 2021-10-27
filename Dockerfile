FROM stevenk11/browser

RUN apt-get update && apt-get install -y --no-install-recommends \
	apt-transport-https \
	curl \
	gnupg \
	libcanberra-gtk* \
	libexif-dev \
	libpangox-1.0-0 \
	libv4l-0 
RUN  curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg \
	&& echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|tee /etc/apt/sources.list.d/brave-browser-release.list \
	&& apt-get update && apt-get install -y --no-install-recommends \
	brave-browser \
	&& apt-get purge --auto-remove -y curl \
	&& rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /usr/bin/startchromium

ENTRYPOINT ["/usr/bin/startchromium"]
