# Use the playwright image from Microsoft which has the browsers pre-installed
FROM mcr.microsoft.com/playwright:v1.31.0-focal

ENV HOME=/usr/src/app

# Enable CI mode (used in the playwright.config.ts)
ENV CI=true

RUN mkdir -p $HOME
WORKDIR $HOME

# Copy all files from the current directory to the container
# (except the ones in .dockerignore)
COPY . .

# Install dependencies
RUN npm install

# Make sure the user has access to the files. It is important to do this
# after the npm install, as the npm install will create a node_modules
# directory with root permissions.
RUN chgrp -R 0 $HOME && chmod -R g=u $HOME

CMD ["npx", "playwright", "test"]
