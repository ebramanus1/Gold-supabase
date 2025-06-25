
CREATE TABLE entries (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  item_id UUID REFERENCES items(id),
  quantity INT NOT NULL,
  entry_date TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

