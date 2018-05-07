# geospatial-database
This project using postgresql to construct geospatial database. The below are tutorial for creating and backing up database by typing the command lines in the terminal.
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

### Import and export data using ogr2ogr
```console
#here is an example to export a table named temp in the database as a shapefile (ses_index.shp)
aijing@aijing-X555LAB:~$ ogr2ogr -f "ESRI Shapefile" ses_index.shp PG:"host=localhost user=postgres dbname=ses password=123456" -sql "SELECT * from temp"
```

### Backup database by pg_dump
```console
aijing@aijing-X555LAB:~$ pg_dump -U postgres -W -F t ses > home\backup_file.tar
```


