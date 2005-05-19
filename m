From: floeff@arcor.de (Florian Effenberger)
Date: Thu, 19 May 2005 06:25:28 +0000
Subject: i2c-ali1535.c:548: warning: initialization from incompatible
Message-Id: <41D7CE7D.7070105@arcor.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <41D6E143.8030204@arcor.de>
In-Reply-To: <41D6E143.8030204@arcor.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

> Oops, my bad. You'd have to copy the file to /usr/local/include/linux,
> not /usr/local/include (please delete the one you copied there). While
> you're at it, you could copy kernel/i2c-algo-bit.h too, since some bus
> drivers in lm_sensors need it.

you were partially right. ;-) By doing

cp kernel/*.h /usr/local/include/linux

it worked, the two files you mentioned were not enough. I checked my 
/usr/local/include/linux before, and it looked like

drwxr-sr-x    2 root     staff        4096 26. Nov 13:06 .
drwxrwsr-x   14 root     staff        4096  2. Jan 10:31 ..
-rw-r--r--    1 root     staff        2197 26. Nov 13:03 i2c-algo-bit.h
-rw-r--r--    1 root     staff        3140 26. Nov 13:03 i2c-algo-biths.h
-rw-r--r--    1 root     staff        1867 26. Nov 13:03 i2c-algo-pcf.h
-rw-r--r--    1 root     staff       12372 26. Nov 13:06 i2c-dev.h
-rw-r--r--    1 root     staff       23343 26. Nov 13:03 i2c.h
-rw-r--r--    1 root     staff       13330 26. Nov 13:03 i2c-id.h
-rw-r--r--    1 root     staff       19385 26. Nov 13:03 i2c-proc.h
-rw-r--r--    1 root     staff       53108 26. Nov 13:06 sensors.h

so the files were old. Might this be a bug in i2c 2.9.0, that it does 
not copy files? I definitely issued a make install and received a 
"Successful"...

However, somethings seems to be wrong nontheless. A "sensors" delivers me:

CPU Fan:  5818 RPM  (min = 84375 RPM, div = 8)          ALARM

look at the min RPM count...

Thanks
Florian
