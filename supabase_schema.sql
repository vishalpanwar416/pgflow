-- PG Manager App - Supabase Database Schema
-- Run this SQL in your Supabase SQL Editor

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 1. Users Table
CREATE TABLE users (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  phone TEXT,
  email TEXT,
  role TEXT NOT NULL CHECK (role IN ('tenant', 'owner')) DEFAULT 'tenant',
  pg_id UUID,
  room_no TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 2. PGs Table
CREATE TABLE pgs (
  pg_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  owner_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  pg_name TEXT NOT NULL,
  address TEXT NOT NULL,
  total_rooms INTEGER DEFAULT 0,
  occupied_rooms INTEGER DEFAULT 0,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 3. Tenants Table
CREATE TABLE tenants (
  tenant_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  pg_id UUID NOT NULL REFERENCES pgs(pg_id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  rent DECIMAL(10,2) NOT NULL,
  room_no TEXT NOT NULL,
  join_date DATE NOT NULL,
  leave_date DATE,
  phone TEXT NOT NULL,
  email TEXT,
  is_active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 4. Bills Table
CREATE TABLE bills (
  bill_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id UUID NOT NULL REFERENCES tenants(tenant_id) ON DELETE CASCADE,
  month DATE NOT NULL,
  amount DECIMAL(10,2) NOT NULL,
  paid BOOLEAN DEFAULT FALSE,
  due_date DATE NOT NULL,
  paid_date TIMESTAMP WITH TIME ZONE,
  payment_method TEXT,
  transaction_id TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 5. Complaints Table
CREATE TABLE complaints (
  complaint_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id UUID NOT NULL REFERENCES tenants(tenant_id) ON DELETE CASCADE,
  issue TEXT NOT NULL,
  status TEXT NOT NULL CHECK (status IN ('open', 'resolved')) DEFAULT 'open',
  category TEXT NOT NULL DEFAULT 'other' CHECK (category IN ('wifi', 'water', 'electricity', 'maintenance', 'other')),
  priority TEXT DEFAULT 'medium' CHECK (priority IN ('low', 'medium', 'high', 'urgent')),
  resolution TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  resolved_at TIMESTAMP WITH TIME ZONE,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 6. Notices Table
CREATE TABLE notices (
  notice_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id UUID NOT NULL REFERENCES tenants(tenant_id) ON DELETE CASCADE,
  notice_date DATE NOT NULL DEFAULT CURRENT_DATE,
  vacate_by DATE NOT NULL,
  reason TEXT,
  status TEXT DEFAULT 'pending' CHECK (status IN ('pending', 'approved', 'rejected')),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 7. Broadcasts Table
CREATE TABLE broadcasts (
  broadcast_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  pg_id UUID NOT NULL REFERENCES pgs(pg_id) ON DELETE CASCADE,
  message TEXT NOT NULL,
  title TEXT,
  priority TEXT DEFAULT 'normal' CHECK (priority IN ('low', 'normal', 'high', 'urgent')),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Add foreign key constraint for users.pg_id
ALTER TABLE users ADD CONSTRAINT fk_users_pg_id 
  FOREIGN KEY (pg_id) REFERENCES pgs(pg_id) ON DELETE SET NULL;

-- Create indexes for better performance
CREATE INDEX idx_users_role ON users(role);
CREATE INDEX idx_users_pg_id ON users(pg_id);
CREATE INDEX idx_pgs_owner_id ON pgs(owner_id);
CREATE INDEX idx_tenants_pg_id ON tenants(pg_id);
CREATE INDEX idx_tenants_room_no ON tenants(room_no);
CREATE INDEX idx_bills_tenant_id ON bills(tenant_id);
CREATE INDEX idx_bills_month ON bills(month);
CREATE INDEX idx_bills_paid ON bills(paid);
CREATE INDEX idx_complaints_tenant_id ON complaints(tenant_id);
CREATE INDEX idx_complaints_status ON complaints(status);
CREATE INDEX idx_notices_tenant_id ON notices(tenant_id);
CREATE INDEX idx_broadcasts_pg_id ON broadcasts(pg_id);

-- Create updated_at trigger function
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Add updated_at triggers
CREATE TRIGGER update_users_updated_at BEFORE UPDATE ON users
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_pgs_updated_at BEFORE UPDATE ON pgs
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_tenants_updated_at BEFORE UPDATE ON tenants
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_bills_updated_at BEFORE UPDATE ON bills
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_complaints_updated_at BEFORE UPDATE ON complaints
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_notices_updated_at BEFORE UPDATE ON notices
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Row Level Security (RLS) Policies

-- Enable RLS on all tables
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE pgs ENABLE ROW LEVEL SECURITY;
ALTER TABLE tenants ENABLE ROW LEVEL SECURITY;
ALTER TABLE bills ENABLE ROW LEVEL SECURITY;
ALTER TABLE complaints ENABLE ROW LEVEL SECURITY;
ALTER TABLE notices ENABLE ROW LEVEL SECURITY;
ALTER TABLE broadcasts ENABLE ROW LEVEL SECURITY;

-- Users policies
CREATE POLICY "Users can view their own profile" ON users
    FOR SELECT USING (auth.uid() = id);

CREATE POLICY "Users can update their own profile" ON users
    FOR UPDATE USING (auth.uid() = id);

-- PGs policies
CREATE POLICY "Owners can view their own PGs" ON pgs
    FOR SELECT USING (auth.uid() = owner_id);

CREATE POLICY "Owners can manage their own PGs" ON pgs
    FOR ALL USING (auth.uid() = owner_id);

-- Tenants policies
CREATE POLICY "Owners can view tenants in their PGs" ON tenants
    FOR SELECT USING (
        EXISTS (
            SELECT 1 FROM pgs WHERE pgs.pg_id = tenants.pg_id AND pgs.owner_id = auth.uid()
        )
    );

CREATE POLICY "Owners can manage tenants in their PGs" ON tenants
    FOR ALL USING (
        EXISTS (
            SELECT 1 FROM pgs WHERE pgs.pg_id = tenants.pg_id AND pgs.owner_id = auth.uid()
        )
    );

-- Bills policies
CREATE POLICY "Owners can view bills for their tenants" ON bills
    FOR SELECT USING (
        EXISTS (
            SELECT 1 FROM tenants 
            JOIN pgs ON tenants.pg_id = pgs.pg_id 
            WHERE tenants.tenant_id = bills.tenant_id AND pgs.owner_id = auth.uid()
        )
    );

CREATE POLICY "Owners can manage bills for their tenants" ON bills
    FOR ALL USING (
        EXISTS (
            SELECT 1 FROM tenants 
            JOIN pgs ON tenants.pg_id = pgs.pg_id 
            WHERE tenants.tenant_id = bills.tenant_id AND pgs.owner_id = auth.uid()
        )
    );

-- Complaints policies
CREATE POLICY "Owners can view complaints for their tenants" ON complaints
    FOR SELECT USING (
        EXISTS (
            SELECT 1 FROM tenants 
            JOIN pgs ON tenants.pg_id = pgs.pg_id 
            WHERE tenants.tenant_id = complaints.tenant_id AND pgs.owner_id = auth.uid()
        )
    );

CREATE POLICY "Owners can manage complaints for their tenants" ON complaints
    FOR ALL USING (
        EXISTS (
            SELECT 1 FROM tenants 
            JOIN pgs ON tenants.pg_id = pgs.pg_id 
            WHERE tenants.tenant_id = complaints.tenant_id AND pgs.owner_id = auth.uid()
        )
    );

-- Notices policies
CREATE POLICY "Owners can view notices for their tenants" ON notices
    FOR SELECT USING (
        EXISTS (
            SELECT 1 FROM tenants 
            JOIN pgs ON tenants.pg_id = pgs.pg_id 
            WHERE tenants.tenant_id = notices.tenant_id AND pgs.owner_id = auth.uid()
        )
    );

CREATE POLICY "Owners can manage notices for their tenants" ON notices
    FOR ALL USING (
        EXISTS (
            SELECT 1 FROM tenants 
            JOIN pgs ON tenants.pg_id = pgs.pg_id 
            WHERE tenants.tenant_id = notices.tenant_id AND pgs.owner_id = auth.uid()
        )
    );

-- Broadcasts policies
CREATE POLICY "Owners can view broadcasts for their PGs" ON broadcasts
    FOR SELECT USING (
        EXISTS (
            SELECT 1 FROM pgs WHERE pgs.pg_id = broadcasts.pg_id AND pgs.owner_id = auth.uid()
        )
    );

CREATE POLICY "Owners can manage broadcasts for their PGs" ON broadcasts
    FOR ALL USING (
        EXISTS (
            SELECT 1 FROM pgs WHERE pgs.pg_id = broadcasts.pg_id AND pgs.owner_id = auth.uid()
        )
    );

-- Functions for common operations

-- Function to get user's PGs
CREATE OR REPLACE FUNCTION get_user_pgs(user_uuid UUID)
RETURNS TABLE (
    pg_id UUID,
    pg_name TEXT,
    address TEXT,
    total_rooms INTEGER,
    occupied_rooms INTEGER
) AS $$
BEGIN
    RETURN QUERY
    SELECT p.pg_id, p.pg_name, p.address, p.total_rooms, p.occupied_rooms
    FROM pgs p
    WHERE p.owner_id = user_uuid;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Function to get PG tenants
CREATE OR REPLACE FUNCTION get_pg_tenants(pg_uuid UUID)
RETURNS TABLE (
    tenant_id UUID,
    name TEXT,
    room_no TEXT,
    rent DECIMAL,
    join_date DATE,
    is_active BOOLEAN
) AS $$
BEGIN
    RETURN QUERY
    SELECT t.tenant_id, t.name, t.room_no, t.rent, t.join_date, t.is_active
    FROM tenants t
    WHERE t.pg_id = pg_uuid;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Function to get tenant bills
CREATE OR REPLACE FUNCTION get_tenant_bills(tenant_uuid UUID)
RETURNS TABLE (
    bill_id UUID,
    month DATE,
    amount DECIMAL,
    paid BOOLEAN,
    due_date DATE,
    paid_date TIMESTAMP WITH TIME ZONE
) AS $$
BEGIN
    RETURN QUERY
    SELECT b.bill_id, b.month, b.amount, b.paid, b.due_date, b.paid_date
    FROM bills b
    WHERE b.tenant_id = tenant_uuid
    ORDER BY b.month DESC;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Insert sample data (optional)
-- Uncomment the following lines to insert sample data for testing

/*
-- Sample PG Owner
INSERT INTO auth.users (id, email, encrypted_password, email_confirmed_at, created_at, updated_at)
VALUES (
    '550e8400-e29b-41d4-a716-446655440000',
    'owner@example.com',
    crypt('password123', gen_salt('bf')),
    NOW(),
    NOW(),
    NOW()
);

INSERT INTO users (id, name, email, role)
VALUES (
    '550e8400-e29b-41d4-a716-446655440000',
    'John Owner',
    'owner@example.com',
    'owner'
);

-- Sample PG
INSERT INTO pgs (pg_id, owner_id, pg_name, address, total_rooms, occupied_rooms)
VALUES (
    '550e8400-e29b-41d4-a716-446655440001',
    '550e8400-e29b-41d4-a716-446655440000',
    'Sunshine PG',
    '123 Main Street, City',
    20,
    15
);
*/ 