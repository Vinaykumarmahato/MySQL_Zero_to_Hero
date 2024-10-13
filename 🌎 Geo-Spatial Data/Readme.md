

# 🌎 Geo-Spatial Data

## What is it?
**Geo-spatial data** refers to data that is related to or represents a geographic location, stored and queried in MySQL using specific data types and functions.

## Why is it important?
- Geo-spatial data handling allows applications to work with location-based information, enabling features like mapping, distance calculations, and spatial queries.
- It is essential for industries like real estate, logistics, and social media that rely on location-based services.

## Real-life Scenario
In a **delivery service application**, storing the geographic coordinates of delivery locations enables the system to optimize routes and improve delivery times.

### Example Code
```sql
-- Create a table with a geo-spatial data column
CREATE TABLE locations (
  id INT PRIMARY KEY,
  name VARCHAR(100),
  coordinates POINT NOT NULL,
  SPATIAL INDEX(coordinates)
);

-- Insert geo-spatial data
INSERT INTO locations (id, name, coordinates)
VALUES (1, 'Delivery Point', ST_GeomFromText('POINT(30.00 10.00)'));

-- Query locations within a certain distance
SELECT name FROM locations
WHERE ST_Distance_Sphere(coordinates, ST_GeomFromText('POINT(30.00 10.00)')) < 1000; -- 1000 meters
