#this is from the backup serverusing world_cities_table in the geography database
#were getting distance from Athens GA to tampa florida.
#getting spherical distance

select ST_Distance_Sphere(point(point1.lng.point1.lat),point(point2.lng.point2.lat
from world_cities_table as point1, world_cities_table as point2
where point1.city = 'Athens' and point1.province = 'Georgia'
and point2.city = 'Tampa';
