From: upgrdman@mindspring.com (Farrell Farahbod)
Date: Thu, 19 May 2005 06:24:06 +0000
Subject: sensors program library problems (more info)
Message-Id: <1058790834.16392.3.camel@farrell.freemans.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

after thinking a little, i thought perhaps it was a problem with my PATH
variable... so:

[upgrdman@farrell upgrdman]$ sensors
sensors: error while loading shared libraries: libsensors.so.2: cannot
open shared object file: No such file or directory
[upgrdman@farrell upgrdman]$ su -c updatedb
Password:
[upgrdman@farrell upgrdman]$ locate libsensors.so.2
/usr/local/lib/libsensors.so.2.0.0
/usr/local/lib/libsensors.so.2
/home/upgrdman/lm_sensors-2.8.0/lib/libsensors.so.2.0.0
/home/upgrdman/lm_sensors-2.8.0/lib/libsensors.so.2
[upgrdman@farrell upgrdman]$ echo $PATH
/usr/local/bin:/usr/bin:/bin:/usr/X11R6/bin:/home/upgrdman/bin
[upgrdman@farrell upgrdman]$ export PATH=$PATH:/usr/local/lib
[upgrdman@farrell upgrdman]$ echo $PATH
/usr/local/bin:/usr/bin:/bin:/usr/X11R6/bin:/home/upgrdman/bin:/usr/local/lib
[upgrdman@farrell upgrdman]$ sensors
sensors: error while loading shared libraries: libsensors.so.2: cannot
open shared object file: No such file or directory
[upgrdman@farrell upgrdman]$ cd /usr/local/lib
[upgrdman@farrell lib]$ ls
bonobo             libgaim-remote.so        libmusicbrainz.so.2     
mplayer
gaim               libgaim-remote.so.0      libmusicbrainz.so.2.0.1 
netscape
galeon             libgaim-remote.so.0.0.0  libsensors.a            
pkgconfig
libdha.so.0        libmusicbrainz.a         libsensors.so
libdha.so.0.1      libmusicbrainz.la        libsensors.so.2
libgaim-remote.la  libmusicbrainz.so        libsensors.so.2.0.0
[upgrdman@farrell lib]$ sensors
sensors: error while loading shared libraries: libsensors.so.2: cannot
open shared object file: No such file or directory
[upgrdman@farrell lib]$

still no success :(

jsut thought this information might help...sorry if it jsut wastes more
of your time.

thanks yet again,

farrell farahbod
