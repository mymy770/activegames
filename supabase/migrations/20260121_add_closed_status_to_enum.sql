-- Migration: Add 'closed' value to order_status enum
-- Date: 2026-01-21
-- This migration adds the 'closed' status to the order_status enum

-- Add 'closed' status to order_status enum
ALTER TYPE order_status ADD VALUE IF NOT EXISTS 'closed';
