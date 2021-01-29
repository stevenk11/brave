FROM stevenk11/ibus

RUN apt-get update && apt-get install -y --no-install-recommends \
	apt-transport-https \
	ca-certificates \
	curl \
	gnupg \
	fonts-liberation \
	hicolor-icon-theme \
	libcanberra-gtk* \
	libexif-dev \
	libgl1-mesa-dri \
	libgl1-mesa-glx \
	libpangox-1.0-0 \
	libv4l-0 \
	fonts-symbola \
	&& curl -sSL https://brave-browser-apt-release.s3.brave.com/brave-core.asc | apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add - \
	&& echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | tee /etc/apt/sources.list.d/brave-browser-release.list \
	&& apt-get update && apt-get install -y --no-install-recommends \
	brave-browser \
	&& apt-get purge --auto-remove -y curl \
	&& rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /usr/bin/startchromium

ENTRYPOINT ["/usr/bin/startchromium"]
