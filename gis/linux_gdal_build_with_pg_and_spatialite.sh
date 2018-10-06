./configure --with-python=yes     \
	    --with-spatialite \
	    --with-pg="/usr/bin/pg_config"         \
	    --with-geotiff=internal \
	    --with-libtiff=internal    \
	    --with-kea=no \
	    > test.log

make clean
make
sudo make install
