./configure --with-python=yes     \
	    --with-sp  atialite \
	    --with-pg="/usr/bin/pg_config"         \
	    --with-geotiff=internal \
	    --with-libtiff=internal    \
	    --with-kea=no \
	    > test.log

make clean
make
sudo make install
