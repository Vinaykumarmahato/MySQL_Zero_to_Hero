-- 🌎 Geo-Spatial Data in MySQL
-- Author: [Your Name]
-- Date: [Date]
-- Description: This script demonstrates how to handle geo-spatial data in MySQL, including creating spatial data types, inserting data, and performing spatial queries.

-- ====================================
-- 📘 Introduction
-- ====================================
-- Geo-spatial data is information that identifies the geographic location and characteristics of features on Earth.
-- MySQL supports spatial data types and functions for storing and querying geo-spatial data, making it suitable for applications like mapping and location services.

-- Key Points:
-- 1. MySQL supports various spatial data types, including POINT, LINESTRING, POLYGON, etc.
-- 2. Spatial indexes can improve the performance of spatial queries.
-- 3. Functions for calculating distances and areas can be used to analyze geo-spatial data.

-- ====================================
-- Step 1: Creating a Table for Geo-Spatial Data
-- ====================================
-- Let's create a table to store information about places with their geographical locations.

-- Drop the table if it already exists (for testing purposes)
DROP TABLE IF EXISTS places;

-- Create a table with a POINT data type for geo-spatial data
CREATE TABLE places (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    location POINT NOT NULL,
    SPATIAL INDEX(location)  -- Create a spatial index on the location column
);

-- Explanation:
-- - The `location` column uses the `POINT` data type to store geographical coordinates (latitude and longitude).
-- - A spatial index is created to optimize spatial queries.

-- ====================================
-- Step 2: Inserting Geo-Spatial Data
-- ====================================
-- We can insert data into the `places` table by using the `POINT` function.

-- Insert geo-spatial data into the `places` table
INSERT INTO places (name, location) VALUES
('Eiffel Tower', POINT(2.2945, 48.8584)),  -- Longitude, Latitude
('Statue of Liberty', POINT(-74.0445, 40.6892)),
('Great Wall of China', POINT(117.2365, 40.4319)),
('Taj Mahal', POINT(78.0421, 27.1751));

-- Explanation:
-- - We insert various landmarks into the table, each represented by a geographic point.

-- ====================================
-- Step 3: Querying Geo-Spatial Data
-- ====================================
-- We can perform spatial queries to find places within a certain distance from a given point.

-- Example: Find places within a 100 km radius from a specific location (longitude, latitude)
SET @origin = POINT(2.3522, 48.8566);  -- Paris, France coordinates

SELECT 
    name,
    ST_Distance_Sphere(location, @origin) AS distance
FROM 
    places
WHERE 
    ST_Distance_Sphere(location, @origin) <= 100000;  -- 100 km in meters

-- Explanation:
-- - The `ST_Distance_Sphere` function calculates the distance between two points on the Earth's surface in meters.
-- - The query finds all places within 100 km from the specified origin (Paris).

-- ====================================
-- Step 4: Using Other Spatial Data Types
-- ====================================
-- MySQL supports other spatial data types like LINESTRING and POLYGON. 

-- Create a table for roads using LINESTRING
DROP TABLE IF EXISTS roads;

CREATE TABLE roads (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    path LINESTRING NOT NULL,
    SPATIAL INDEX(path)  -- Create a spatial index on the path column
);

-- Explanation:
-- - The `path` column uses the `LINESTRING` data type to store a series of points representing a road.

-- Insert some roads into the `roads` table
INSERT INTO roads (name, path) VALUES
('Route 66', LINESTRING(POINT(-99.9018, 34.4489), POINT(-85.0594, 41.7018))),
('Pacific Coast Highway', LINESTRING(POINT(-122.6282, 37.7649), POINT(-118.4814, 34.7528)));

-- ====================================
-- Step 5: Working with Polygons
-- ====================================
-- Create a table for areas using POLYGON
DROP TABLE IF EXISTS parks;

CREATE TABLE parks (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    area POLYGON NOT NULL,
    SPATIAL INDEX(area)  -- Create a spatial index on the area column
);

-- Insert a park area into the `parks` table (e.g., a rectangular area)
INSERT INTO parks (name, area) VALUES
('Central Park', POLYGON(POINT(-73.9654, 40.7851), POINT(-73.9580, 40.7851), POINT(-73.9580, 40.7988), POINT(-73.9654, 40.7988), POINT(-73.9654, 40.7851)));

-- Explanation:
-- - The `area` column uses the `POLYGON` data type to define a geographical area, such as a park.

-- ====================================
-- Step 6: Spatial Analysis
-- ====================================
-- We can perform spatial analysis to determine relationships between geometric shapes.

-- Example: Check if a point is within a polygon
SELECT 
    name,
    ST_Contains(area, POINT(-73.9654, 40.7925)) AS is_inside  -- Check if the point is inside Central Park
FROM 
    parks;

-- Explanation:
-- - The `ST_Contains` function checks if the specified point lies within the defined area.

-- ====================================
-- 🚀 Conclusion
-- ====================================
-- MySQL provides robust support for geo-spatial data types and functions, enabling efficient storage and querying of geographical information.
-- You can use spatial types like POINT, LINESTRING, and POLYGON, along with functions for calculating distances and performing spatial analysis.
-- These capabilities make MySQL suitable for applications that require geographic data handling, such as mapping and location-based services.

-- End of script.
