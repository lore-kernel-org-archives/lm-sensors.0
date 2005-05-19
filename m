From: marco@iftbqp.com (marco)
Date: Thu, 19 May 2005 06:24:31 +0000
Subject: compilation error
Message-Id: <20031223135304.7b789b49.marco@iftbqp.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all. I'm very new to this and I must say that I understand about
nothing in sensors and i2c etc...

But I have a problem with my cooling fan since I migred to debian. The
fan doesn't stop. I'm looking for a solution to make it works as it
works on macosx... 

Then I try to compile lm-sensor in the hope it will provide me some
feature to do this...

I've compiled 2.4 benh kernel (ben1) without i2c modules

i2c-2.8.2 compile  and installs well.

Now  lm_sensors-2.8.2...

I checked for the includes dir.
ls -l /usr/local/include 
total 0
lrwxrwxrwx    1 root     staff          28 2003-05-27 17:12 linux ->
/usr/src/linux/include/linux

I try to make clean i2c, lm_sensors, the kernel tree etc. But I still
have the error :

..
gcc -M -MG  -D__SMP__ -DMODVERSIONS -include
/lib/modules/2.4.23-ben1/build/include/linux/modversions.h -D__KERNEL__
-DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include
-I/usr/local/include  -I/lib/modules/2.4.23-ben1/build/include -nostdinc
-I /usr/lib/gcc-lib/powerpc-linux/3.3.3/include  -Wall -O2 
kernel/busses/i2c-nforce2.c | \
       	sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-nforce2.d
kernel/busses/i2c-nforce2.o: Makefile '`dirname
kernel/busses/i2c-nforce2.d`/Module.mk' @' > kernel/busses/i2c-nforce2.d
cat kernel/include/sensors.h.template > kernel/include/sensors.h
awk '/SENSORS SYSCTL START/,/SENSORS SYSCTL END/' kernel/chips/*.c >>
kernel/include/sensors.h
echo '#endif' >> kernel/include/sensors.h
gcc -M -MG -I. -Ikernel/include -I/usr/local/include  -Wall -O2 
prog/sensors/chips.c | \
       	sed -e 's@^\(.*\)\.o:@prog/sensors/chips.rd
prog/sensors/chips.ro: Makefile '`dirname
prog/sensors/chips.rd`/Module.mk' @' > prog/sensors/chips.rd
make: *** No rule to make target `sys/io.h', needed by
`prog/dump/isadump.rd'.  Stop.

Could someone help me. Or give me some pointers to any solution for
managing the fan on g4 1ghz (the mirror one;))

thanks

-- 
marco
--
Cl? PGP publique : http://iftbqp.mine.nu/marco.asc
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20031223/f3496f65/attachment.bin
