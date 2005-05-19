From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:32 +0000
Subject: new drivers for linux 2.6, testers wanted
Message-Id: <20040101092047.3c6a40b4.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I have new i2c drivers for linux 2.6 and am looking for testers.

*** i2c-parport and i2c-parport light ***

These are replacements for the i2c-philips-par, i2c-elv and i2c-velleman
drivers, as well as for the i2c-old i2c-parport driver as found under
drivers/media/video in linux 2.4. My reason for writing them, as already
discussed on this list, is that all these drivers basically do the same
thing, so I thought it would be easier to maintain a single driver
instead of four. As Simon Vogl pointed out that using a direct I/O
access (as done in i2c-elv and i2c-velleman) could be prefered over
clean parport access (as done in i2c-philips-par) on embedded devices,
I finally wrote two drivers instead of one. But both drivers support all
devices, it's just a matter of how they are accessed (and wether the
driver depends on the parport driver).

I made it so that the definition of the adapters (i.e. how to set and
get SDA and SCL, basically) is completely separated from the code
itself. Thus, adding support for a new adapter is simply adding a new
set of data to the definition table, describing how the adapter works,
in a single file.

This means that all simple parallel port adapters are virtually
supported. The i2c-pport driver we have in CVS isn't supported yet
because it works a bit differently, but I believe that extending the
current driver(s) to support it should be possible (although it can be
discussed wether it's worth it).

So, if any of you have parallel port i2c adapters and are running a 2.6
kernel, that would be nice to you to give a try to my new drivers.
You'll have to pass the type parameter that is correct for your board:
 0 = Philips
 2 = Velleman
 3 = ELV
 4 = ADM evaluation board

If you have a different hardware setup, add the definition for it in
i2c-parallel.h and send me a patch so that I can update on my side too.

The drivers are available here as a patch against linux-2.6.1-rc1:
http://delvare.nerim.net/i2c/linux-2.6/linux-2.6.1-rc1-i2c-parport.diff

I could only test with my ADM eval board, and it worked ok with
both drivers. If they are confirmed to work, we could get rid of all
other parallel port i2c drivers in 2.6.

*** lm90 ***

This is my lm90 driver ported to 2.6. It supports the LM90 and ADM1032
chips. Lm_sensors2 CVS as of today has support for it. I tested it on my
ADM1032 eval board and it worked OK.

If anyone wants to give it a try, it's there:
http://delvare.nerim.net/i2c/linux-2.6/linux-2.6.1-rc1-i2c-lm90.diff

Thanks and happy new year everyone.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
