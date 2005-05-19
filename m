From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:50 +0000
Subject: [BK PATCH] Yet more i2c driver changes for 2.5.65
Message-Id: <20030323080719.GD26145@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com

Hi,

Here are some more i2c driver changes, they include the stuff I sent out
Friday, but haven't ended up in your tree yet, and 4 patches to fix up
some drivers in the rest of the kernel tree that were broken by my
previous i2c changes.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/i2c-2.5

I'll post just the new patches to the mailing lists.

thanks,

greg k-h

 drivers/acorn/char/i2c.c                  |    4 
 drivers/i2c/busses/i2c-ali15x3.c          |    8 -
 drivers/i2c/busses/i2c-amd756.c           |    6 -
 drivers/i2c/busses/i2c-amd8111.c          |    4 
 drivers/i2c/busses/i2c-i801.c             |    8 -
 drivers/i2c/busses/i2c-isa.c              |    4 
 drivers/i2c/busses/i2c-piix4.c            |    8 -
 drivers/i2c/chips/adm1021.c               |   21 +--
 drivers/i2c/chips/lm75.c                  |   14 +-
 drivers/i2c/i2c-algo-bit.c                |   13 +-
 drivers/i2c/i2c-algo-pcf.c                |   19 +--
 drivers/i2c/i2c-core.c                    |   99 ++++++++--------
 drivers/i2c/i2c-dev.c                     |   21 +--
 drivers/i2c/i2c-elektor.c                 |   10 +
 drivers/i2c/i2c-elv.c                     |    6 -
 drivers/i2c/i2c-philips-par.c             |    4 
 drivers/i2c/i2c-proc.c                    |  180 +++++++-----------------------
 drivers/i2c/i2c-velleman.c                |    4 
 drivers/i2c/scx200_acb.c                  |   32 ++---
 drivers/ieee1394/pcilynx.c                |    4 
 drivers/media/video/adv7175.c             |   22 ++-
 drivers/media/video/bt819.c               |   33 +++--
 drivers/media/video/bt856.c               |   27 ++--
 drivers/media/video/bttv-if.c             |   22 ++-
 drivers/media/video/msp3400.c             |   32 ++---
 drivers/media/video/saa5249.c             |   13 +-
 drivers/media/video/saa7110.c             |   19 +--
 drivers/media/video/saa7111.c             |   21 ++-
 drivers/media/video/saa7134/saa7134-i2c.c |   10 +
 drivers/media/video/saa7185.c             |   19 +--
 drivers/media/video/tda7432.c             |   16 +-
 drivers/media/video/tda9875.c             |   16 +-
 drivers/media/video/tda9887.c             |   14 +-
 drivers/media/video/tuner-3036.c          |    6 -
 drivers/media/video/tuner.c               |   29 ++--
 drivers/media/video/tvaudio.c             |   44 +++----
 drivers/video/matrox/i2c-matroxfb.c       |   11 +
 include/linux/i2c.h                       |   33 +++--
 38 files changed, 424 insertions(+), 432 deletions(-)
------


Greg Kroah-Hartman <greg@kroah.com>:
  o i2c: fix up drivers/video/matrox/i2c-matroxfb.c due to previous i2c changes
  o i2c: fix up drivers/ieee1394/pcilynx.c due to previous i2c changes
  o i2c: fix up drivers/acorn/char/i2c.c due to previous i2c changes
  o i2c: fix up drivers/media/video/* due to previous i2c changes
  o i2c: ugh, clean up lindent mess in i2c-proc.c::i2c_detect()
  o i2c: fix up the chip driver names to play nice with sysfs
  o i2c: actually register the i2c client device with the driver core
  o i2c: Removed the name variable from i2c_client as the dev one should be used instead
  o i2c: remove the data field from struct i2c_client
  o i2c: add struct device to i2c_client structure
  o i2c: remove *data from i2c_adapter, as dev->data should be used instead
  o i2c: remove i2c_adapter->name and use dev->name instead

Petr Vandrovec <vandrove@vc.cvut.cz>:
  o Fix kobject_get oopses triggered by i2c in 2.5.65-bk
