#!/usr/bin/env node

// This script simply starts the server using the server start script. It's
// not intended to do any heavy lifting, this script is solely intended to be
// executable to start the server.

require('./dist/server').default().catch((error) => {
  console.error('Unable to start server: %s', error);
  console.error(error);
});
