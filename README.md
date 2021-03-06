# geospatial-database
This project uses postgresql to construct geospatial database. The below are tutorial for creating and backing up database by typing the command lines in the terminal.
### Install postgresql version 9.6
```console
aijing@aijing-X555LAB:~$ sudo apt-get install postgresql-9.6
aijing@aijing-X555LAB:~$ sudo apt-get install postgresql-9.6-postgis-2.3 postgresql-contrib-9.6 postgresql-9.6-postgis-scripts

```

### Download postgis extension for creating a geospatial database
```console
#to get the commandline tools shp2pgsql, raster2pgsql you need to do this
aijing@aijing-X555LAB:~$ sudo apt-get install postgis
```
### log in the postgresql and creat database and extension.
Login to PostgreSQL shell using the command
```console
aijing@aijing-X555LAB:~$ sudo -u postgres psql
```
Create a database and enable postgis extension by typing following SQL in PostgreSQL
```console
CREATE DATABASE built_environment;
\connect built_environment;

CREATE SCHEMA postgis;
ALTER DATABASE built_environment SET search_path=public, postgis, contrib;
\connect built_environment;  -- this is to force new search path to take effect
CREATE EXTENSION postgis SCHEMA postgis;
SELECT postgis_full_version();
```

### Import and export data using ogr2ogr
```console
#import a shapefile (contains GIS) into the database, ses
aijing@aijing-X555LAB:~$ shp2pgsql -I -s 4269 city_parks.shp city_park | psql -U postgres -d ses
#here is an example to export a table named percent_tree_cover in the database as a shapefile (tree_cover.shp)
aijing@aijing-X555LAB:~$ ogr2ogr -f "ESRI Shapefile" tree_cover.shp PG:"host=localhost user=postgres dbname=built_environment password=123456" -sql "SELECT * FROM percent_tree_cover"
```

### Backup database by pg_dump
```console
aijing@aijing-X555LAB:~$ pg_dump -U postgres -W -F t ses > home\backup_file.tar
```

Further details and instructions could be seen in the links:
http://trac.osgeo.org/postgis/wiki/UsersWikiPostGIS23UbuntuPGSQL96Apt

http://www.gdal.org/ogr2ogr.html

It should be noted that sometimes, the data were downloaded as a format of geoJson and geodatabase, it could also be directly imported into the PostGIS. However, if you want to use shapefile for the purpose of analysis (e.g spatial join in ArcGIS), you could convert those format into shp file by using ogr2org (instruction seen in the link):

https://morphocode.com/using-ogr2ogr-convert-data-formats-geojson-postgis-esri-geodatabase-shapefiles/
