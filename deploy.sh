#!/bin/bash

echo "🚀 Starting Trading Bot Deployment on EC2"
echo "=========================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running as root
if [ "$EUID" -eq 0 ]; then
    print_error "Please don't run this script as root"
    exit 1
fi

# Update system
print_status "Updating system packages..."
sudo yum update -y || sudo apt update -y

# Install Node.js if not installed
if ! command -v node &> /dev/null; then
    print_status "Installing Node.js..."
    curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
    sudo apt-get install -y nodejs
else
    print_status "Node.js already installed: $(node --version)"
fi

# Install PM2 globally
if ! command -v pm2 &> /dev/null; then
    print_status "Installing PM2..."
    sudo npm install -g pm2
else
    print_status "PM2 already installed: $(pm2 --version)"
fi

# Install Git if not installed
if ! command -v git &> /dev/null; then
    print_status "Installing Git..."
    sudo yum install git -y || sudo apt install git -y
fi

# Create logs directory
print_status "Creating logs directory..."
mkdir -p logs

# Install dependencies
print_status "Installing npm dependencies..."
npm install

# Build the application
print_status "Building the application..."
npm run build

# Check if build was successful
if [ $? -ne 0 ]; then
    print_error "Build failed! Please check the error messages above."
    exit 1
fi

# Check if .env file exists
if [ ! -f .env ]; then
    print_warning ".env file not found. Please create it with your configuration:"
    echo "VITE_TELEGRAM_BOT_TOKEN=your_bot_token_here"
    echo "VITE_TELEGRAM_CHAT_ID=your_chat_id_here"
    echo "VITE_SUPABASE_URL=your_supabase_url"
    echo "VITE_SUPABASE_ANON_KEY=your_supabase_anon_key"
    echo "NODE_ENV=production"
    echo "PORT=3000"
fi

# Start PM2 processes
print_status "Starting PM2 processes..."
pm2 start ecosystem.config.cjs

# Save PM2 configuration
print_status "Saving PM2 configuration..."
pm2 save

# Setup PM2 startup script
print_status "Setting up PM2 startup script..."
pm2 startup

print_status "Deployment completed successfully!"
print_status "Your trading bot is now running on port 3000"
print_status "Use 'pm2 status' to check the status of your services"
print_status "Use 'pm2 logs' to view logs"
print_status "Use 'pm2 monit' to monitor resources"

echo ""
echo "📊 Useful PM2 Commands:"
echo "  pm2 status          - Check service status"
echo "  pm2 logs            - View all logs"
echo "  pm2 logs trading-bot-web - View web server logs"
echo "  pm2 logs trading-bot-background - View background service logs"
echo "  pm2 monit           - Monitor resources"
echo "  pm2 restart all     - Restart all services"
echo "  pm2 stop all        - Stop all services"
echo "  pm2 delete all      - Delete all services"
