From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:04 +0000
Subject: Pre-release tests
Message-Id: <20030711175013.21dc2706.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030707213700.3eef7104.khali@linux-fr.org>
In-Reply-To: <20030707213700.3eef7104.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > The message would explain that we plan to submit a patch to the
> > Linux kernel so that all devices are back with the next Linux
> > version.
> 
> Hm, I've asked for such a patch already, but I'll do it again before
> it's too late for 2.4.22.  Anyone want to make this up and send it to
> me?

Hi Greg,

I just finished the patch. It is of course based on the patch generated
by mkpatch from i2c-2.8.0. I checked and converted all kernel drivers
that make use of our i2c structures. Here is the list:

drivers/acorn/char/i2c.c
drivers/acorn/char/pcf8583.c
drivers/i2c/i2c-adap-ite.c
drivers/i2c/i2c-keywest.c
drivers/i2c/scx200_acb.c
drivers/i2c/scx200_i2c.c
drivers/ieee1394/pcilynx.c
drivers/media/video/bt832.c
drivers/media/video/bttv-if.c
drivers/media/video/i2c-old.c
drivers/media/video/msp3400.c
drivers/media/video/saa5249.c
drivers/media/video/tda7432.c
drivers/media/video/tda9875.c
drivers/media/video/tda9887.c
drivers/media/video/tuner-3036.c
drivers/media/video/tuner.c
drivers/media/video/tvaudio.c
drivers/media/video/tvmixer.c
drivers/pcmcia/sa1100_stork.c
drivers/sound/dmasound/dac3550a.c
drivers/sound/dmasound/tas3001c.c
drivers/video/matrox/i2c-matroxfb.c
drivers/video/matrox/matroxfb_maven.c

I then had to modify the support files of the i2c directory to integrate
our new drivers. Mkpatch is supposed to do so, but it doesn't.

patching file drivers/i2c/Config.in
patching file drivers/i2c/Makefile

I also modified the two following files because I believe they contained
errors.

drivers/media/video/Makefile
drivers/media/video/saa7146.h

For clarity, I represented the changes in the i2c directory in the array
below. First column shows the files we have in i2c-2.8.0. Second column
shows files present in the Linux 2.4.21 drivers/i2c directory. Third
column shows the merge result (where + means the file was added, - means
it was deleted and U means it was updated.)


* I2C 2.8.0 ************* LINUX 2.4.21 *********** LINUX 2.4.22 ******

i2c-adap-ibm_ocp.c                              + i2c-adap-ibm_ocp.c
                        i2c-adap-ite.c            i2c-adap-ite.c
i2c-algo-8xx.c                                  + i2c-algo-8xx.c
i2c-algo-8xx.h                                  + i2c-algo-8xx.h
i2c-algo-bit.c          i2c-algo-bit.c          U i2c-algo-bit.c
i2c-algo-bit.h          i2c-algo-bit.h          U i2c-algo-bit.h
i2c-algo-biths.c
i2c-algo-biths.h
i2c-algo-ibm_ocp.c                              + i2c-algo-ibm_ocp.c
i2c-algo-ibm_ocp.h                              + i2c-algo-ibm_ocp.h
                        i2c-algo-ite.c            i2c-algo-ite.c
                        i2c-algo-ite.h            i2c-algo-ite.h
i2c-algo-pcf.c          i2c-algo-pcf.c          U i2c-algo-pcf.c
i2c-algo-pcf.h          i2c-algo-pcf.h          U i2c-algo-pcf.h
i2c-core.c              i2c-core.c              U i2c-core.c
i2c-dev.c               i2c-dev.c               U i2c-dev.c
i2c-dev.h               i2c-dev.h               U i2c-dev.h
i2c-elektor.c           i2c-elektor.c           U i2c-elektor.c
                        i2c-elektor.h           -
i2c-elv.c               i2c-elv.c               U i2c-elv.c
i2c-frodo.c                                     + i2c-frodo.c
i2c-id.h                i2c-id.h                U i2c-id.h
                        i2c-ite.h                 i2c-ite.h
                        i2c-keywest.c             i2c-keywest.c
                        i2c-keywest.h             i2c-keywest.h
i2c-pcf-epp.c                                   + i2c-pcf-epp.c
i2c-pcf8584.h           i2c-pcf8584.h           U i2c-pcf8584.h
i2c-philips-par.c       i2c-philips-par.c       U i2c-philips-par.c
i2c-pport.c                                     + i2c-pport.c
i2c-proc.c              i2c-proc.c              U i2c-proc.c
i2c-proc.h              i2c-proc.h              U i2c-proc.h
i2c-rpx.c                                       + i2c-rpx.c
i2c-velleman.c          i2c-velleman.c          U i2c-velleman.c
i2c.h                   i2c.h                   U i2c.h
                        scx200.h                  scx200.h
                        scx200_acb.c              scx200_acb.c
                        scx200_gpio.h             scx200_gpio.h
                        scx200_i2c.c              scx200_i2c.c

**********************************************************************

For files that were updated, we should make sure we are not undoing some
changes that would have occured in the kernel. Or are the two trees so
different that my remark doesn't even make sense?

The changeset is composed of 14 diff files, the bigger one being of
course the core i2c-2.8.0 patch (230k). The 13 other patches are the
fixes I added, and range from 450 bytes to 9.9k. Total size 254k.

Do you prefer a single patch or individual diffs? Do you want me to
generate the core patch against 2.4.21, 2.4.21-bk7 or 2.4.22-pre4? (or
you can do it yourself)

A few questions just to make sure I understood everything (well, as far
as this patch is concerned ;)):

1* I left all drivers using i2c-old untouched. It looks like they are
not concerned by our changes.

2* I fixed i2c_adapter and i2c_driver, but left i2c_client and
i2c_algorithm untouched (actually I did exactly what MDS told me, no
more, no less). It looks like the i2c_algorithm structure as a new owner
field, just as i2c_adapter and i2c_driver do. Is it safe not to fill it?

I tested my work as much as possible, but I of course don't have all the
hardware I would need to test everything completely.

Patches available on request (or should I post them on the list?)
Comments welcome. Testers welcome too.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
