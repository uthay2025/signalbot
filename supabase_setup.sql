-- Supabase Database Setup for Trading Signal System
-- Run this script in your Supabase SQL editor

-- Create signals table
CREATE TABLE IF NOT EXISTS signals (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    pair TEXT NOT NULL,
    entry_price DECIMAL(20, 8) NOT NULL,
    stop_loss DECIMAL(20, 8) NOT NULL,
    take_profit_1 DECIMAL(20, 8) NOT NULL,
    take_profit_2 DECIMAL(20, 8) NOT NULL,
    take_profit_3 DECIMAL(20, 8),
    confidence_score DECIMAL(5, 2) NOT NULL,
    signal_type TEXT NOT NULL CHECK (signal_type IN ('buy', 'sell', 'neutral')),
    timeframe TEXT NOT NULL,
    status TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'tp1_hit', 'tp2_hit', 'tp3_hit', 'sl_hit', 'completed')),
    current_price DECIMAL(20, 8) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    closed_at TIMESTAMP WITH TIME ZONE
);

-- Create signal_logs table
CREATE TABLE IF NOT EXISTS signal_logs (
    log_id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    signal_id UUID NOT NULL REFERENCES signals(id) ON DELETE CASCADE,
    event TEXT NOT NULL CHECK (event IN ('tp1_hit', 'tp2_hit', 'tp3_hit', 'sl_hit', 'completed')),
    price_at_event DECIMAL(20, 8) NOT NULL,
    timestamp TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_signals_pair ON signals(pair);
CREATE INDEX IF NOT EXISTS idx_signals_status ON signals(status);
CREATE INDEX IF NOT EXISTS idx_signals_created_at ON signals(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_signals_confidence ON signals(confidence_score DESC);
CREATE INDEX IF NOT EXISTS idx_signal_logs_signal_id ON signal_logs(signal_id);
CREATE INDEX IF NOT EXISTS idx_signal_logs_timestamp ON signal_logs(timestamp DESC);

-- Create a function to automatically update closed_at when status changes
CREATE OR REPLACE FUNCTION update_signal_closed_at()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.status IN ('completed', 'sl_hit') AND OLD.status NOT IN ('completed', 'sl_hit') THEN
        NEW.closed_at = NOW();
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create trigger to automatically update closed_at
CREATE TRIGGER trigger_update_signal_closed_at
    BEFORE UPDATE ON signals
    FOR EACH ROW
    EXECUTE FUNCTION update_signal_closed_at();

-- Create a view for signal statistics
CREATE OR REPLACE VIEW signal_stats AS
SELECT 
    COUNT(*) as total_signals,
    COUNT(*) FILTER (WHERE status = 'pending') as pending_signals,
    COUNT(*) FILTER (WHERE status LIKE 'tp%') as tp_hit_signals,
    COUNT(*) FILTER (WHERE status = 'sl_hit') as sl_hit_signals,
    COUNT(*) FILTER (WHERE status = 'completed') as completed_signals,
    AVG(confidence_score) as avg_confidence,
    AVG(CASE WHEN status = 'completed' THEN 
        CASE 
            WHEN signal_type = 'buy' THEN (current_price - entry_price) / entry_price * 100
            WHEN signal_type = 'sell' THEN (entry_price - current_price) / entry_price * 100
            ELSE 0
        END
    END) as avg_profit_percentage
FROM signals;

-- Create a function to get signal performance
CREATE OR REPLACE FUNCTION get_signal_performance(signal_id UUID)
RETURNS TABLE(
    signal_uuid UUID,
    pair TEXT,
    signal_type TEXT,
    entry_price DECIMAL(20, 8),
    current_price DECIMAL(20, 8),
    profit_loss DECIMAL(10, 2),
    profit_loss_percentage DECIMAL(10, 2),
    status TEXT,
    confidence_score DECIMAL(5, 2),
    created_at TIMESTAMP WITH TIME ZONE,
    closed_at TIMESTAMP WITH TIME ZONE
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        s.id,
        s.pair,
        s.signal_type,
        s.entry_price,
        s.current_price,
        CASE 
            WHEN s.signal_type = 'buy' THEN (s.current_price - s.entry_price)
            WHEN s.signal_type = 'sell' THEN (s.entry_price - s.current_price)
            ELSE 0
        END as profit_loss,
        CASE 
            WHEN s.signal_type = 'buy' THEN (s.current_price - s.entry_price) / s.entry_price * 100
            WHEN s.signal_type = 'sell' THEN (s.entry_price - s.current_price) / s.entry_price * 100
            ELSE 0
        END as profit_loss_percentage,
        s.status,
        s.confidence_score,
        s.created_at,
        s.closed_at
    FROM signals s
    WHERE s.id = signal_id;
END;
$$ LANGUAGE plpgsql;

-- Enable Row Level Security (RLS) for better security
ALTER TABLE signals ENABLE ROW LEVEL SECURITY;
ALTER TABLE signal_logs ENABLE ROW LEVEL SECURITY;

-- Create policies for public read access (you can modify these based on your needs)
CREATE POLICY "Allow public read access to signals" ON signals
    FOR SELECT USING (true);

CREATE POLICY "Allow public read access to signal_logs" ON signal_logs
    FOR SELECT USING (true);

-- Create policies for authenticated users to insert/update
CREATE POLICY "Allow authenticated users to insert signals" ON signals
    FOR INSERT WITH CHECK (true);

CREATE POLICY "Allow authenticated users to update signals" ON signals
    FOR UPDATE USING (true);

CREATE POLICY "Allow authenticated users to insert signal_logs" ON signal_logs
    FOR INSERT WITH CHECK (true);

-- Insert some sample data for testing (optional)
-- INSERT INTO signals (pair, entry_price, stop_loss, take_profit_1, take_profit_2, take_profit_3, confidence_score, signal_type, timeframe, current_price) VALUES
-- ('BTCUSDT', 45000.00, 44000.00, 46000.00, 47000.00, 48000.00, 8.5, 'buy', '1H', 45500.00),
-- ('ETHUSDT', 3200.00, 3100.00, 3300.00, 3400.00, 3500.00, 7.8, 'buy', '1H', 3250.00),
-- ('SOLUSDT', 95.00, 90.00, 100.00, 105.00, 110.00, 6.5, 'sell', '1H', 92.00);

-- Grant necessary permissions
GRANT USAGE ON SCHEMA public TO anon, authenticated;
GRANT ALL ON ALL TABLES IN SCHEMA public TO anon, authenticated;
GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO anon, authenticated;
GRANT ALL ON ALL FUNCTIONS IN SCHEMA public TO anon, authenticated;

-- Create a function to clean up old completed signals (optional)
CREATE OR REPLACE FUNCTION cleanup_old_signals(days_to_keep INTEGER DEFAULT 30)
RETURNS INTEGER AS $$
DECLARE
    deleted_count INTEGER;
BEGIN
    DELETE FROM signals 
    WHERE status IN ('completed', 'sl_hit') 
    AND created_at < NOW() - INTERVAL '1 day' * days_to_keep;
    
    GET DIAGNOSTICS deleted_count = ROW_COUNT;
    RETURN deleted_count;
END;
$$ LANGUAGE plpgsql;

-- Create a scheduled job to clean up old signals (optional - requires pg_cron extension)
-- SELECT cron.schedule('cleanup-old-signals', '0 2 * * *', 'SELECT cleanup_old_signals(30);');

COMMENT ON TABLE signals IS 'Stores trading signals with real-time status tracking';
COMMENT ON TABLE signal_logs IS 'Stores historical events for each signal (TP/SL hits)';
COMMENT ON VIEW signal_stats IS 'Provides aggregated statistics for all signals'; 