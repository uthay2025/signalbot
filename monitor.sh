#!/bin/bash

echo "📊 Trading Bot Monitoring Dashboard"
echo "=================================="

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}�� PM2 Status:${NC}"
pm2 status

echo ""
echo -e "${BLUE}💾 System Resources:${NC}"
echo "CPU Usage: $(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'%' -f1)%"
echo "Memory Usage: $(free | grep Mem | awk '{printf("%.1f%%", $3/$2 * 100.0)}')"
echo "Disk Usage: $(df -h / | awk 'NR==2 {print $5}')"

echo ""
echo -e "${BLUE}�� Application Logs (Last 10 lines):${NC}"
echo "Web Server:"
pm2 logs trading-bot-web --lines 10 --nostream

echo ""
echo "Background Service:"
pm2 logs trading-bot-background --lines 10 --nostream

echo ""
echo -e "${BLUE}🌐 Network Status:${NC}"
echo "Port 3000: $(netstat -tlnp | grep :3000 || echo 'Not listening')"
echo "Port 80: $(netstat -tlnp | grep :80 || echo 'Not listening')"

echo ""
echo -e "${BLUE}📅 Last Restart:${NC}"
pm2 show trading-bot-web | grep "restart time" || echo "No restart info available"
