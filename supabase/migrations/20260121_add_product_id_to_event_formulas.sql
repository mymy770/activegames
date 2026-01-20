-- Migration: Add product_id FK to icount_event_formulas
-- Purpose: Link formulas directly to products for stable tier-based naming
-- Date: 2026-01-21

-- Add product_id column as FK to icount_products
ALTER TABLE icount_event_formulas
ADD COLUMN IF NOT EXISTS product_id UUID REFERENCES icount_products(id) ON DELETE SET NULL;

-- Create index for efficient lookups
CREATE INDEX IF NOT EXISTS idx_event_formulas_product_id
ON icount_event_formulas(product_id);

-- Add comment explaining the migration
COMMENT ON COLUMN icount_event_formulas.product_id IS
  'Direct link to icount_products. Products use tier-based codes (event_laser_5_15) instead of price-based codes.';

COMMENT ON COLUMN icount_event_formulas.price_per_person IS
  'Price per person. When changed, the linked product unit_price is updated and synced to iCount.';
