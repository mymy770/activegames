-- Migration: Add columns for order closing functionality
-- Date: 2026-01-21
-- This migration adds the necessary columns to track closed orders and their invoices

-- =============================================
-- Add columns to orders table for closing
-- =============================================

-- Add closed_at timestamp
ALTER TABLE orders
ADD COLUMN IF NOT EXISTS closed_at TIMESTAMPTZ;

-- Add closed_by user reference
ALTER TABLE orders
ADD COLUMN IF NOT EXISTS closed_by UUID REFERENCES auth.users(id);

-- Add iCount invoice+receipt ID
ALTER TABLE orders
ADD COLUMN IF NOT EXISTS icount_invrec_id INTEGER;

-- Add iCount invoice+receipt URL
ALTER TABLE orders
ADD COLUMN IF NOT EXISTS icount_invrec_url TEXT;

-- =============================================
-- Add index for closed orders queries
-- =============================================
CREATE INDEX IF NOT EXISTS idx_orders_closed_at
ON orders(closed_at)
WHERE closed_at IS NOT NULL;

-- =============================================
-- Comments for documentation
-- =============================================
COMMENT ON COLUMN orders.closed_at IS 'Timestamp when order was closed (finalized with invoice)';
COMMENT ON COLUMN orders.closed_by IS 'User who closed the order';
COMMENT ON COLUMN orders.icount_invrec_id IS 'iCount invoice+receipt combined document ID (created at close)';
COMMENT ON COLUMN orders.icount_invrec_url IS 'URL to view the iCount invoice+receipt document';
