# Background Signal Service

A standalone background service that generates trading signals and sends Telegram notifications without requiring the web interface to be running.

## 🚀 Features

### 📊 Independent Signal Generation
- **Background Processing**: Runs independently of the web interface
- **Real-Time Analysis**: Continuous technical analysis every 2 minutes
- **Multi-Cryptocurrency**: Monitors 15+ cryptocurrencies simultaneously
- **High Accuracy**: Uses comprehensive technical analysis engine

### 📱 Telegram Notifications
- **Real-Time Alerts**: Instant notifications for high-confidence signals
- **Rich Formatting**: Detailed signal information with emojis and formatting
- **Error Notifications**: Alerts for service issues and errors
- **Market Updates**: Periodic market summaries

### 💾 Database Integration
- **Signal Storage**: Automatically stores signals in Supabase database
- **Signal History**: Maintains history of all generated signals
- **Verification System**: Only stores verified signals with high confidence

## 🛠️ Setup Instructions

### 1. Environment Configuration

Create a `.env` file in the project root:

```bash
# Supabase Configuration (Required)
VITE_SUPABASE_URL=your_supabase_project_url
VITE_SUPABASE_ANON_KEY=your_supabase_anon_key

# Telegram Bot Configuration (Optional but recommended)
VITE_TELEGRAM_BOT_TOKEN=your_telegram_bot_token
VITE_TELEGRAM_CHAT_ID=your_telegram_chat_id
```

### 2. Telegram Bot Setup

#### Step 1: Create a Telegram Bot
1. Open Telegram and search for `@BotFather`
2. Send `/newbot` command
3. Follow the instructions to create your bot
4. Save the bot token (format: `1234567890:ABCdefGHIjklMNOpqrsTUVwxyz`)

#### Step 2: Get Your Chat ID
1. Start a conversation with your bot
2. Send any message to the bot
3. Visit: `https://api.telegram.org/bot<YOUR_BOT_TOKEN>/getUpdates`
4. Find your `chat_id` in the response (it's a number)

#### Step 3: Configure Environment
Add your bot token and chat ID to the `.env` file:
```bash
VITE_TELEGRAM_BOT_TOKEN=1234567890:ABCdefGHIjklMNOpqrsTUVwxyz
VITE_TELEGRAM_CHAT_ID=123456789
```

### 3. Install Dependencies

```bash
npm install
```

### 4. Run the Background Service

```bash
# Start the background service
npm run start-bot

# Or alternatively
npm run background
```

## 📊 Service Configuration

### Default Settings
- **Update Interval**: 2 minutes
- **Minimum Confidence**: 5/10
- **Telegram Notifications**: Enabled (for confidence ≥6)
- **Database Storage**: Enabled
- **Monitoring**: 15 cryptocurrencies

### Customization

You can modify the service configuration in `src/services/backgroundSignalService.ts`:

```typescript
const config = {
  symbols: [
    'BTCUSDT', 'ETHUSDT', 'SOLUSDT', 'XRPUSDT', 'SUIUSDT', 'DOGEUSDT',
    'ADAUSDT', 'NEARUSDT', 'AVAXUSDT', 'TRXUSDT', 'SHIBUSDT', 'HBARUSDT',
    'ONDOUSDT', 'APTUSDT', 'POLUSDT'
  ],
  interval: 2 * 60 * 1000, // 2 minutes
  minConfidence: 5,
  enableTelegram: true,
  enableDatabase: true,
  enableLogging: true
};
```

## 📱 Telegram Notifications

### Signal Notifications
The service sends detailed signal notifications including:

- **Signal Type**: BUY/SELL/HOLD with emoji indicators
- **Price Information**: Current price, entry, stop loss, take profit levels
- **Confidence Score**: 1-10 scale with risk assessment
- **Technical Analysis**: All indicators (RSI, MACD, BB, ATR, OBV, Volume, Orderbook)
- **Key Levels**: Support and resistance levels
- **Market Data**: 24h change and momentum

### Notification Types

#### 1. Trading Signals
```
🟢 TRADING SIGNAL: BTCUSDT ✅

💰 Signal: BUY
💵 Price: $43,250.50
📊 Confidence: 7.5/10
🟡 Risk: MEDIUM

📈 Entry: $43,250.50
🛑 Stop Loss: $42,385.49
🎯 Take Profit 1: $44,547.02
🎯 Take Profit 2: $45,843.53

📊 Technical Analysis:
• RSI: 35.2 (Bullish (Approaching Oversold))
• MACD: 0.0023 (Bullish Crossover)
• BB: Middle Range (Bullish (Near Lower Band))
• ATR: 0.0156 (Medium Volatility)
• OBV: 1.2M (Bullish Volume Confirmation)
• Volume: 2.1x (Volume Spike)
• Orderbook: 15.3% (BUYING)
• Trend: BULLISH (+2.45%)

📍 Key Levels:
• Support: $42,150.00
• Resistance: $44,500.00

📉 24h Change: +1.85%

⏰ Time: 12/15/2024, 2:30:45 PM

#BTC #Trading #Signal
```

#### 2. Market Updates
```
📊 MARKET UPDATE

Generated 3 new signals with confidence ≥5/10

📈 Monitoring: BTCUSDT, ETHUSDT, SOLUSDT, XRPUSDT, SUIUSDT, DOGEUSDT, ADAUSDT, NEARUSDT, AVAXUSDT, TRXUSDT, SHIBUSDT, HBARUSDT, ONDOUSDT, APTUSDT, POLUSDT

⏰ Time: 12/15/2024, 2:30:45 PM

#MarketUpdate #Trading
```

#### 3. Error Notifications
```
⚠️ ERROR NOTIFICATION

Context: Background Service

Error: Failed to fetch technical indicators for BTCUSDT

⏰ Time: 12/15/2024, 2:30:45 PM

#Error #TradingBot
```

#### 4. Startup Notifications
```
🚀 TRADING BOT STARTED

✅ Signal generation active
✅ Technical analysis running
✅ Telegram notifications enabled

⏰ Started: 12/15/2024, 2:30:45 PM

#TradingBot #Started
```

## 🔧 Running Options

### 1. Development Mode
```bash
# Start the web interface
npm run dev

# In another terminal, start the background service
npm run start-bot
```

### 2. Production Mode
```bash
# Build the project
npm run build

# Start only the background service
npm run start-bot
```

### 3. Server Deployment
```bash
# Install dependencies
npm install

# Start background service
npm run start-bot

# Keep running with PM2 (recommended for production)
npm install -g pm2
pm2 start "npm run start-bot" --name "trading-bot"
pm2 save
pm2 startup
```

## 📊 Monitoring and Logs

### Console Output
The service provides detailed console output:

```
🚀 Starting Trading Bot Background Service
==========================================

📱 Telegram Configuration:
   Enabled: true
   Has Token: true
   Has Chat ID: true

⚙️  Service Configuration:
   Symbols: 15 coins
   Interval: 120 seconds
   Min Confidence: 5/10
   Telegram: Enabled
   Database: Enabled

🧪 Testing Telegram connection...
✅ Telegram connection successful!

🔄 Starting background service...
✅ Background service started successfully
📊 Monitoring 15 symbols
⏰ Update interval: 120 seconds
📈 Min confidence: 5/10
📱 Telegram: Enabled
💾 Database: Enabled

✅ Service is now running!
   Press Ctrl+C to stop the service

🔄 Generating signals at 12/15/2024, 2:30:45 PM
✅ Signal generation completed in 15432ms
📊 Summary: 15 total, 8 verified, 6 buy, 2 sell
📈 Avg confidence: 6.2/10
📱 Sending 3 Telegram notifications
✅ Telegram notification sent for BTCUSDT
✅ Telegram notification sent for ETHUSDT
✅ Telegram notification sent for SOLUSDT
```

### Log Files
For production deployment, consider using log files:

```bash
# Redirect output to log file
npm run start-bot > trading-bot.log 2>&1

# Or with PM2
pm2 start "npm run start-bot" --name "trading-bot" --log trading-bot.log
```

## 🔒 Security Considerations

### Environment Variables
- Never commit your `.env` file to version control
- Use strong, unique tokens for Telegram bot
- Regularly rotate your Supabase keys

### Rate Limiting
- The service respects API rate limits
- Updates every 2 minutes to avoid overwhelming APIs
- Error handling for network issues

### Error Handling
- Automatic retry mechanisms
- Graceful error recovery
- Error notifications via Telegram

## 🚀 Deployment Options

### 1. Local Machine
```bash
npm run start-bot
```

### 2. VPS/Cloud Server
```bash
# Install Node.js and npm
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs

# Clone and setup
git clone <your-repo>
cd signal-bot
npm install
npm run start-bot
```

### 3. Docker Deployment
```dockerfile
FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 3000
CMD ["npm", "run", "start-bot"]
```

### 4. PM2 Process Manager (Recommended)
```bash
# Install PM2
npm install -g pm2

# Start the service
pm2 start "npm run start-bot" --name "trading-bot"

# Save configuration
pm2 save

# Setup auto-start
pm2 startup
```

## 📈 Performance Optimization

### Memory Usage
- The service is memory-efficient
- Signal history is limited to last 100 signals
- Automatic garbage collection

### CPU Usage
- Lightweight processing
- Efficient API calls
- Minimal computational overhead

### Network Usage
- Optimized API requests
- Batch processing where possible
- Connection pooling

## 🔧 Troubleshooting

### Common Issues

#### 1. Telegram Notifications Not Working
```bash
# Check configuration
echo $VITE_TELEGRAM_BOT_TOKEN
echo $VITE_TELEGRAM_CHAT_ID

# Test connection
curl "https://api.telegram.org/bot<YOUR_TOKEN>/getMe"
```

#### 2. Supabase Connection Issues
```bash
# Check environment variables
echo $VITE_SUPABASE_URL
echo $VITE_SUPABASE_ANON_KEY

# Test connection
curl -X GET "$VITE_SUPABASE_URL/rest/v1/" \
  -H "apikey: $VITE_SUPABASE_ANON_KEY"
```

#### 3. API Rate Limiting
- The service automatically handles rate limits
- If you see rate limit errors, increase the interval
- Monitor API usage in your Binance account

### Debug Mode
Enable detailed logging by modifying the service configuration:

```typescript
enableLogging: true,
interval: 5 * 60 * 1000, // 5 minutes for debugging
```

## 📞 Support

For issues and questions:
1. Check the console output for error messages
2. Verify your environment configuration
3. Test individual components (Telegram, Supabase, Binance API)
4. Check the logs for detailed error information

## ⚠️ Disclaimer

This service is for educational purposes only. All signals are based on technical analysis and should not be used for actual trading decisions. Always do your own research and consult with qualified financial advisors before making any investment decisions.
