From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: i2c & lm_sensors for RH
Message-Id: <20030805203134.6470c569.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030802172008.GA10034@puariko.nirvana>
In-Reply-To: <20030802172008.GA10034@puariko.nirvana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I managed to merge and build i2c&lm_sensors into the kernel sources
> for RH 9/8.0/7. The only change to i2c&lm_sensors I had to make were
> prepatches to get the code base patchable for some parts that changed
> up to the 2.4.21 release. So no real patches for i2c/lm_sensors in the
> kernel space. :)

I'm not sure I understood everything there, but as long as you think
there's nothing we should integrate, it's OK ;)

> I have now turned to the userspace. In order to build the lm_sensors
> userland I need to compile against the kernel headers including the
> patched in i2c headers (so I2C_HEADERS and LINUX_HEADERS point to the
> same dir).
> 
> Since I am building against kernel headers, does that mean that the
> resulting tools are only applicable to that kernel? Or are they to any
> kernel that has i2c/lm_sensors 2.8.0 patched in?

LM Sensors userspace mostly depends on I2C version, not on kernel
version (well, you have to stick to Linux 2.4 however). As for the I2C
version, a minimal version is required for any given lm_sensors, and the
tools compiled using these headers should then be usable with all later
versions.

You think you compile against kernel headers because i2c headers are
there, but you could as well copy all i2c headers to /usr/local/include
and compile against them there.

> I wonder if I need LINUX_HEADERS at all, since I am not building
> external modules, and whether I should simply "carry" the i2c tarball
> with the lm_sensors source package and build against the i2c headers
> in that tarball (in order to build independently of the running kernel
> or installed kernel sources). Does that make sense?

You do not need LINUX_HEADERS at all. It is used for userspace tools in
lm_sensors 2.8.0's Makefile but this is a bug and has been fixed in CVS
(you may checkout the new one if you want).

You won't be able to use the headers directly from the i2c tarball
because lm_sensors expects them in a linux/ subdirectory. But you can
build such a subdirectory rather easily IMHO, and that may suit your
needs for the lm_sensors package build process.

Hope that helps.

BTW: We had a Red Hat user reporting he couldn't get lm_sensors to
compile on his RH9. The message is available here:
http://archives.andrew.net.au/lm-sensors/msg03872.html
Could you please take a look at the log and tell me if you have any
idea?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
