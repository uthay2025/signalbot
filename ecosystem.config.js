module.exports = {
  apps: [
    {
      name: 'trading-bot-web',
      script: 'dist/server.js',
      instances: 1,
      autorestart: true,
      watch: false,
      max_memory_restart: '1G',
      env: {
        NODE_ENV: 'production',
        PORT: 3000
      },
      error_file: './logs/web-error.log',
      out_file: './logs/web-out.log',
      log_file: './logs/web-combined.log',
      time: true
    },
    {
      name: 'trading-bot-background',
      script: 'src/scripts/runBackgroundService.ts',
      instances: 1,
      autorestart: true,
      watch: false,
      max_memory_restart: '1G',
      env: {
        NODE_ENV: 'production'
      },
      error_file: './logs/background-error.log',
      out_file: './logs/background-out.log',
      log_file: './logs/background-combined.log',
      time: true
    }
  ]
};
