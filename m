From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:23:55 +0000
Subject: i2c-2.7.0 won't comile
Message-Id: <20030508015255.GB23199@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <3EB966D2.5090506@mechanized-mind.net>
In-Reply-To: <3EB966D2.5090506@mechanized-mind.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Gustave Nylander <gustave@mechanized-mind.net> [2003-05-07 16:04:34 -0400]:
> I'm stuck at pretty much the first step, tyring to do a 'make' on the 
> i2c package. It looks like i2c is not integrated into my kernel, and not 
> loading as a module already, so I don't know what the problem is. I've 
> included some details:
> 
> OS: Red Hat 9.0
> Kernel: 2.4.20-9
> Motherboard: MSI KT3 Ultra2 (MS-6380E)
> Chipset: VIA VT8235 Chipset
> Sensors: Winbond W83697HF

Here is what I did, step by step, to compile sensors 2.7.0 vs. RH 9.

1) Install the appropriate kernel-source RPM.  Copy the config file
that matches your kernel into its proper place, something like this:

$ cp /usr/src/linux-2.4.20-9/configs/kernel-2.4.20-i686.config \
     /usr/src/linux-2.4.20-9/.config

2) Do *not* do anything else in that tree.  Don't "make clean", don't
"make dep", nothing.  Somehow, that screws it all up.  Sorry I haven't
looked into it more than that.  Uninstall & reinstall the RPM if you
must.

NOTE: from here on, I assume you're already running the kernel that
matches the config above.  That does make it easier.

3) In the I2C makefile uncomment these lines (if you do have SMP,
you can figure out what to do):

SMP := 0

MODVER := 1

MODPREF := /lib/modules/$(KERNELVERSION)

4) Now build & install I2C.

NOTE: If you're using the same tree which failed to build earlier,
please do a "make clean" first.

5) Now lm_sensors2 is almost the same procedure except the makefile
needs a very minor patch (in addition to the uncommenting)...

Index: Makefile
=================================RCS file: /home/cvs/lm_sensors2/Makefile,v
retrieving revision 1.60
diff -r1.60 Makefile
181c181
< ALL_CPPFLAGS := -I. -Ikernel/include -I$(I2C_HEADERS) -I$(LINUX_HEADERS)
---
> ALL_CPPFLAGS := -I. -Ikernel/include -isystem $(I2C_HEADERS) -isystem $(LINUX_HEADERS)

If you're interested in the details of why this is needed, look here:

http://archives.andrew.net.au/lm-sensors/msg02538.html

After you apply this patch, the rest follows the readme.  Let me know
if that doesn't work.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
