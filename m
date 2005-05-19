From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:30 +0000
Subject: Installation report/Feedback
Message-Id: <20031214180703.79dbd334.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031207183312.GA855@GreenHouse.dorchain.net>
In-Reply-To: <20031207183312.GA855@GreenHouse.dorchain.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Here you are:
>  i2cdump 1 0x2e
> No size specified (using byte-data access)
> (...)
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: ff ff ff ff ff ff ff ff ff ff ff ff XX ff XX ff
> 10: ff XX ff ff ff ff ff ff ff ff XX XX ff ff ff ff
> 20: 39 3a 00 00 00 00 59 2a 00 00 00 XX 00 ff 00 00
> 30: 00 00 00 00 00 XX 00 50 4b 50 4b 00 00 00 00 00
> 40: 0d 00 00 00 00 80 ff ff ff XX ff ff a3 5c 70 ff   
> 50: 06 04 03 64 7f 4b 46 XX 46 00 fa bc ff ff ff ff
> 60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 70: ff ff ff ff ff ff ff ff ff ff XX ff ff ff ff ff
> 80: ff ff ff ff ff 00 18 ff ff ff ff ff ff ff ff ff
> 90: ff XX ff ff ff ff ff ff ff XX ff ff ff ff ff ff
> a0: ff ff ff ff ff ff ff ff ff ff XX ff ff ff ff ff
> b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff XX ff
> e0: c9 02 3a 71 39 38 37 XX ff ff ff ff ff ff ff ff
> f0: ff 2e 00 ff 00 62 00 ff 00 00 XX 00 00 XX ff ff

Hu-ho. These "XX" are bad. I would say your I2C bus is somehow broken.
Does an i2cdump on your other chip (ASB100) leads to the same kind of
output?
Does a new i2cdump on the W83L785TS-S displace the "XX"?
What if you unload all i2c client modules before dumping?
What if you try the "consectutive byte address mode"? (i2cdump 1 0x2e c)

Anyway, I just finished the new driver and commited it to our CVS
repository. Support is preliminary, which means that the driver should
work with minimal functions, and sensors-detect knows about the driver,
but there is no sensors/libsensors support yet.

Could you please give it a try? You'll also have to get an updated
i2c-id.h file. No need to reinstall i2c completely, get the updated file
from here:
http://www2.lm-sensors.nu/~lm78/cvs/i2c/kernel/i2c-id.h
Then just update your local cvs lm_sensors2 checkout, compile it (maybe
with DEBUG set at first), install it, and try loading the w83l785ts
module.

If it works, you should be able to see a temp file here:
/proc/sys/dev/sensors/w83l785ts-i2c-0-2e/

If you cat that file, you'll see, in order, the high temperature limit
and the measured limit. Contrary to other chips, you can't change the
limit (or at least that what the poor data sheet makes me think).

If this works, I'll add support to the libsensors library, the sensors
program, the sensors.conf.eg file and write a documentation file.

> Something like
> --- Makefile.orig       2003-12-14 15:40:38.000000000 +0100
> +++ Makefile    2003-12-14 15:44:53.000000000 +0100
> @@ -95,6 +95,8 @@
>  # library files (both static and shared) will be installed.
>  LIBDIR := $(PREFIX)/lib
>   
> +EXLDFLAGS := -Wl,-rpath,$(LIBDIR)
> +
>  # You should not need to change this. It is the directory into which
>  # the executable program files will be installed. BINDIR for programs
>  # that  are also useful for normal users, SBINDIR for programs that
>  # can only be run
> 
> So that libraries are found. Verify e.g. with
>  ldd /usr/local/lm_sensors/bin/sensors
>         libsensors.so.3 => /usr/local/lm_sensors/lib/libsensors.so.3
>         (0x40018000) libc.so.6 => /lib/libc.so.6 (0x40045000)
>         libm.so.6 => /lib/libm.so.6 (0x40178000)
>         /lib/ld-linux.so.2 => /lib/ld-linux.so.2 (0x40000000)
> 
> Unfortunately I do not understand the recursive make system well
> enough ATM for a complete patch.

Hmm. If I understand you well, this is meant so that at *runtime*, the
sensors binary knows where to look for libsensors? There's already
/etc/ld.so.conf for that, and LD_LIBRARY_PATH too. I'm not sure that
binaries looking at specific places by themselves are considered very
safe. And even without security considerations, what if the end-user
wants to change which libraries are used? Wouldn't he/she get confused
that the binary doesn't follow the usual ld.so.conf order?

> Additionally, some toolchains use -R as the linker argument for the
> same effect (e.g. Solaris ld). Luckily IMHO gnu ld is a sure
> assumption.

Since lm_sensors is targeted at Linux only, yes, I also think this is a
safe assumption.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
