From: gene.heskett@verizon.net (Gene Heskett)
Date: Thu, 19 May 2005 06:24:09 +0000
Subject: subscribe gene.heskett@verizon.net
Message-Id: <200308030426.38858.gene.heskett@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200308012231.07647.gene.heskett@verizon.net>
In-Reply-To: <200308012231.07647.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Saturday 02 August 2003 23:50, Mark M. Hoffman wrote:
>* Mark M. Hoffman <mhoffman@lightlink.com> [2003-08-02 23:31:55 
-0400]:
>> This just tells your system to update its list of where to find
>> shared libraries.  There will be notes about this at the end of
>> the second "make install" - read them and you should be all set.
>
>Oops, I lied.  The notes are actually in lm_sensors2/INSTALL...

I put it into my script, worked just fine. :-)

>> If `sensors' returns some error message about not being able to
>> load libsensors, you have to add the directory in which it is
>> installed (by default /usr/local/lib) to /etc/ld.so.conf and run
>> `ldconfig'.
>
>Dunno why I thought that was added to the "make install" notes -
> sorry.
>
>Regards,

This script I've been talking about is one that I punched up quite 
some time back because I got tired of scrolling back thru 1/2 meg of 
shell history to see if a compile had failed.  I put everything in 
order and ended every active line with a && \
that way, if there is an error, its still on-screen when I get back to 
that screen.

Here it is:
---
#!/bin/sh
## this script assumes you have downloaded, unpacked and linked 
## kernel-whatever.version.minor to "/usr/src/linux"
## First, set the version string to match the Makefile setting
VER=2.4.22-pre10
## For use with the lm_sensors kit, you'll need the following lines 
## inserted into your /etc/rc.d/rc.local script
[snip ancient history]
##------------------
## And add these lines to /etc/conf.modules
# I2C module options
#alias char-major-89 i2c-dev
##------------------
## Now, the real work.  This assumes you have copied your
## .config and .config.old
## files from the source directory of your previous kernel install, 
## and have done 'make oldconfig' in the new source directory and 
## answered all the questions, and then do a 'make xconfig' to 
## check/change anything you wanted to

## The above is NOT for major version upgrades, you must start from 
## scratch, do NOT copy over the older .config's when upping from 
## 2.2.x to 2.4.x

## I've re-arranged this to be one contiguous command line, because 
## this way if there is an error, it dies right there instead of 
## making you scroll back 300k in the history to check for errors.

make clean && \
make dep && \
make bzImage && \
make modules && \
rm -f /boot/vmlinuz-$VER-old && \
touch /boot/vmlinuz-$VER && \
mv -f /boot/vmlinuz-$VER /boot/vmlinuz-$VER-old && \
cp -f arch/i386/boot/bzImage /boot/vmlinuz-$VER && \
rm -fR /lib/modules/$VER.old && \
touch /lib/modules/$VER && \
mv -f /lib/modules/$VER /lib/modules/$VER.old && \
make modules_install && \
rm -f /boot/System.map-$VER.old && \
cp -f System.map /boot/System.map-$VER && \
cd /boot && \
rm -f System.map && \
ln -s System.map-$VER System.map && \
cd /usr/src/i2c-2.7.0 && \
echo "Makeing in i2c-2.7.0 now" && \
make clean && \
make && \
make install && \
# this s/b version 2.7.0
cd /usr/src/lm_sensors-2.7.0 && \
echo "Makeing in lm_sensors-2.7.0 now" && \
make clean && \
make  && \
make install && \
ldconfig && \
echo All done! reboot and chose your kernel at the lilo or grub prompt
------------
as you can see, it also saves the previous version if its a remake.  
Handy for reversions if the new one doesn't work. :)

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.
