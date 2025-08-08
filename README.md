# Live Signal Terminal with Comprehensive Technical Analysis Engine

A high-accuracy cryptocurrency trading signal platform with real-time price data and comprehensive technical analysis from Binance API, featuring advanced indicators for maximum precision.

## 🚀 Features

### 📊 Real-Time Data
- **Live Price Data**: Real-time cryptocurrency prices from Binance API
- **Market Overview**: Multi-coin price tracking with 24h statistics
- **Advanced Technical Indicators**: Complete suite of professional-grade indicators
- **Interactive Charts**: Beautiful price charts with technical overlays

### 🎯 Comprehensive Technical Analysis Engine

#### Core Indicators
- **RSI (Relative Strength Index)**: Momentum oscillator with overbought/oversold detection
- **MACD (Moving Average Convergence Divergence)**: Trend-following momentum indicator
- **Bollinger Bands**: Volatility indicator with width and %B analysis
- **ATR (Average True Range)**: Volatility measurement for risk assessment
- **OBV (On-Balance Volume)**: Volume-based trend confirmation
- **Volume Spike Detection**: Real-time volume anomaly detection
- **Orderbook Imbalance Analysis**: Market depth and buying/selling pressure

#### Advanced Features
- **Support & Resistance Levels**: Dynamic calculation of key price levels
- **Trend Analysis**: Multi-timeframe trend detection (bullish/bearish/sideways)
- **Momentum Calculation**: Price momentum percentage analysis
- **Risk Assessment**: Volatility-based risk level classification
- **Signal Confluence**: Multi-indicator confirmation for higher accuracy

### 📈 Trading Tools
- **AI-Powered Signal Generation**: Advanced algorithm with 8+ indicator confluence
- **Risk Calculator**: ATR-based position sizing and risk management
- **Trade Log**: Track and analyze your trading performance
- **Alert System**: Price and signal alerts with customizable thresholds

### 📱 Background Service & Telegram Notifications
- **Independent Operation**: Runs without web interface
- **Telegram Notifications**: Real-time signal alerts
- **Continuous Monitoring**: 24/7 signal generation
- **Error Notifications**: Service status alerts
- **Market Updates**: Periodic summaries

### 📚 Educational Content
- **Technical Analysis Education**: Learn about all implemented indicators
- **Indicator Explanations**: Detailed guides for each technical indicator
- **Risk Management**: Best practices for safe trading

## 🔧 Technical Analysis Engine

### Implemented Indicators

#### 1. RSI (Relative Strength Index)
- **Period**: 14 (default)
- **Overbought**: > 70 (Bearish signal)
- **Oversold**: < 30 (Bullish signal)
- **Neutral Zone**: 30-70
- **Analysis**: Momentum oscillator for trend strength

#### 2. MACD (Moving Average Convergence Divergence)
- **Fast EMA**: 12 periods
- **Slow EMA**: 26 periods
- **Signal Line**: 9 periods
- **Analysis**: Trend-following momentum indicator
- **Signals**: Bullish/Bearish crossovers

#### 3. Bollinger Bands
- **Period**: 20
- **Standard Deviation**: 2
- **Enhanced Metrics**: Width and %B calculation
- **Analysis**: Volatility and price position relative to bands

#### 4. ATR (Average True Range)
- **Period**: 14
- **Purpose**: Volatility measurement
- **Risk Assessment**: High/Medium/Low volatility classification
- **Stop Loss**: ATR-based dynamic stop loss calculation

#### 5. OBV (On-Balance Volume)
- **Purpose**: Volume-based trend confirmation
- **Analysis**: Volume accumulation/distribution
- **Signals**: Volume confirmation or divergence

#### 6. Volume Analysis
- **Volume Spike Detection**: 2x average volume threshold
- **Volume Ratio**: Current vs average volume
- **Volume Trend**: Increasing/Decreasing/Stable
- **Analysis**: Volume pattern recognition

#### 7. Orderbook Analysis
- **Bid/Ask Volume**: Real-time orderbook depth
- **Imbalance Calculation**: Buying vs selling pressure
- **Spread Analysis**: Bid-ask spread percentage
- **Pressure Detection**: Buying/Selling/Neutral pressure

#### 8. Support & Resistance
- **Dynamic Calculation**: Based on recent highs/lows
- **Key Levels**: Automatically identified support/resistance
- **Price Action**: Relative position to key levels

#### 9. Trend Analysis
- **Multi-Timeframe**: 1H, 4H, 1D analysis
- **Trend Classification**: Bullish/Bearish/Sideways
- **Momentum Calculation**: Price change percentage

### Signal Generation Algorithm

The platform uses a sophisticated multi-indicator confluence system:

#### Confidence Calculation (Weighted)
- **RSI**: 15% weight
- **MACD**: 15% weight
- **Bollinger Bands**: 15% weight
- **ATR**: 10% weight
- **OBV**: 10% weight
- **Volume Analysis**: 10% weight
- **Orderbook Analysis**: 10% weight
- **Moving Averages**: 10% weight
- **Trend & Momentum**: 5% bonus

#### Signal Direction Logic
- **Strength-Weighted Majority**: Considers both signal count and strength
- **Minimum Threshold**: Requires at least 2 confirming indicators
- **Confluence Detection**: Multiple indicators pointing in same direction

#### Risk Management
- **ATR-Based Stop Loss**: Dynamic stop loss using ATR multiplier
- **Risk Level Classification**: LOW/MEDIUM/HIGH based on volatility
- **Position Sizing**: Risk-adjusted position sizing

## 🛠️ Installation

1. Clone the repository
2. Install dependencies:
   ```bash
   npm install
   ```

3. **Environment Setup** (Required for Supabase integration):
   
   Create a `.env` file in the project root with your Supabase credentials:
   ```bash
   # Supabase Configuration
   VITE_SUPABASE_URL=your_supabase_project_url
   VITE_SUPABASE_ANON_KEY=your_supabase_anon_key
   
   # Telegram Bot Configuration (Optional but recommended)
   VITE_TELEGRAM_BOT_TOKEN=your_telegram_bot_token
   VITE_TELEGRAM_CHAT_ID=your_telegram_chat_id
   
   # Example:
   # VITE_SUPABASE_URL=https://your-project-id.supabase.co
   # VITE_SUPABASE_ANON_KEY=your-anon-key-here
   # VITE_TELEGRAM_BOT_TOKEN=1234567890:ABCdefGHIjklMNOpqrsTUVwxyz
   # VITE_TELEGRAM_CHAT_ID=123456789
   ```

4. Start the development server:
   ```bash
   npm run dev
   ```

5. Open your browser to `http://localhost:5173`

## 📱 Background Service Setup

### Quick Start
```bash
# Start the background service (runs independently)
npm run start-bot
```

### Telegram Bot Setup
1. Create a bot with @BotFather on Telegram
2. Get your bot token and chat ID
3. Add to your `.env` file
4. Start the service

### Detailed Setup
See [README_BACKGROUND_SERVICE.md](README_BACKGROUND_SERVICE.md) for complete setup instructions.

## 📊 Supported Cryptocurrencies

### Major Coins
- **BTC/USDT** (Bitcoin)
- **ETH/USDT** (Ethereum)
- **SOL/USDT** (Solana)
- **XRP/USDT** (Ripple)

### Altcoins
- **SUI/USDT** (Sui)
- **DOGE/USDT** (Dogecoin)
- **ADA/USDT** (Cardano)
- **NEAR/USDT** (Near Protocol)
- **AVAX/USDT** (Avalanche)
- **TRX/USDT** (Tron)
- **SHIB/USDT** (Shiba Inu)
- **HBAR/USDT** (Hedera)
- **ONDO/USDT** (Ondo)
- **APT/USDT** (Aptos)
- **POL/USDT** (Polygon)

## 🔍 Technical Analysis Features

### Real-Time Indicators
All indicators are calculated in real-time using live market data:

```typescript
// Example: Get comprehensive technical analysis
const indicators = await binanceApi.getTechnicalIndicators('BTCUSDT', '1h');

// Available indicators:
{
  rsi: number,                    // RSI value
  macd: { macd, signal, histogram },
  bollingerBands: { upper, middle, lower, width, percentB },
  atr: number,                    // Average True Range
  obv: number,                    // On-Balance Volume
  obvChange: number,              // OBV change
  volumeAnalysis: {               // Volume analysis
    currentVolume, averageVolume, volumeSpike, volumeRatio, volumeTrend
  },
  orderbookAnalysis: {            // Orderbook analysis
    bidVolume, askVolume, imbalance, spread, depth, pressure
  },
  support: number,                // Support level
  resistance: number,             // Resistance level
  trend: string,                  // 'bullish' | 'bearish' | 'sideways'
  momentum: number                // Price momentum percentage
}
```

### Signal Quality
- **Verification System**: Only signals with confidence > 6 are verified
- **Multi-Indicator Confluence**: Requires multiple confirming indicators
- **Real-Time Updates**: Data updates every 30 seconds
- **Risk Assessment**: Automatic risk level classification

## 📈 API Integration

### Binance API Endpoints
- **Price Data**: Real-time and 24h ticker data
- **Chart Data**: Kline/candlestick data for technical analysis
- **Orderbook Data**: Real-time orderbook depth analysis
- **Technical Indicators**: Calculated on-the-fly from price data

### Supported Timeframes
- **1H**: 1-hour candlesticks (default)
- **4H**: 4-hour candlesticks
- **1D**: Daily candlesticks

## 🎯 Signal Generation Process

1. **Data Collection**: Fetch real-time price and volume data
2. **Indicator Calculation**: Calculate all technical indicators
3. **Signal Analysis**: Analyze each indicator for bullish/bearish signals
4. **Confluence Detection**: Identify multi-indicator confirmation
5. **Confidence Calculation**: Weighted confidence score (1-10)
6. **Risk Assessment**: Determine risk level based on volatility
7. **Signal Generation**: Generate BUY/SELL/HOLD signals
8. **Database Storage**: Store high-confidence signals

## 🔧 Dependencies

- **React 18**: Modern React with hooks
- **TypeScript**: Type-safe development
- **Tailwind CSS**: Utility-first CSS framework
- **Recharts**: Beautiful charting library
- **Axios**: HTTP client for API calls
- **Lucide React**: Icon library
- **@supabase/supabase-js**: Supabase client library

## 📚 Educational Disclaimer

This platform is for educational purposes only. All signals are based on technical analysis and should not be used for actual trading decisions. Always do your own research and consult with qualified financial advisors before making any investment decisions.

## 🚀 Getting Started

1. **Setup Environment**: Configure your Supabase credentials
2. **Install Dependencies**: Run `npm install`
3. **Start Development**: Run `npm run dev`
4. **Access Platform**: Open `http://localhost:5173`
5. **Explore Features**: Navigate through different tabs
6. **Technical Analysis**: Use the dedicated Technical Analysis tab
7. **Monitor Signals**: Watch real-time signal generation
8. **Background Service**: Run `npm run start-bot` for independent operation

## 🔍 Advanced Features

### Technical Analysis Tab
- **Comprehensive Indicators**: View all technical indicators for any symbol
- **Real-Time Updates**: Live indicator calculations
- **Visual Analysis**: Color-coded indicator cards
- **Summary Reports**: Detailed analysis summaries

### Background Service
- **Independent Operation**: Runs without web interface
- **Telegram Notifications**: Real-time signal alerts
- **Continuous Monitoring**: 24/7 signal generation
- **Error Handling**: Automatic error recovery and notifications

### Signal Quality Metrics
- **Confidence Score**: 1-10 scale based on indicator confluence
- **Verification Status**: VERIFIED/PENDING/REJECTED
- **Risk Level**: LOW/MEDIUM/HIGH based on volatility
- **Signal Strength**: Weighted indicator analysis

### Risk Management
- **ATR-Based Stops**: Dynamic stop loss calculation
- **Position Sizing**: Risk-adjusted position sizing
- **Volatility Assessment**: Real-time volatility analysis
- **Support/Resistance**: Key level identification

This comprehensive technical analysis engine provides professional-grade trading signals with high accuracy through multi-indicator confluence analysis. 