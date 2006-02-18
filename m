From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 18 Feb 2006 10:34:20 +0000
Subject: [lm-sensors] Can't access procfs/sysfs file with kernel
Message-Id: <20060218113420.5fbb17fe.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1896546447.20060217184242@via.com.ua>
In-Reply-To: <1896546447.20060217184242@via.com.ua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

> I tried to get lm_sensors run on my Red Hat Fedora Core 3
> (native kernel 2.6.9-1.667smp). The motherboard is Intel
> SE7221BK1-E. From the documentation on the motherboard I
> learned that this motherboard uses LM96000 sensor for hardware
> monitoring
> (ftp://download.intel.com/support/motherboards/server/sb/se7221bk1tps1.pdf
> page 80). From LM-Sensors website I learned that I have to
> use lm85 driver with this chipset. So I got the latest version
> of lm_sensors (2.10.0) and tried to force this driver to run
> as it subscribed in
> http://secure.netroedge.com/~lm78/newdrivers.html.
> Here are my actions:
> 
> $ i2cdetect -l
> i2c-0   smbus           SMBus I801 adapter at 0400              Non-I2C SMBus adapter
> 
> $ i2cdetect 0
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-0.
> I will probe address range 0x03-0x77.
> Continue? [Y/n]
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          XX XX XX XX XX 08 XX XX XX XX XX XX XX
> 10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 30: XX XX 32 XX XX XX XX XX XX XX XX XX XX XX XX XX
> 40: XX XX 42 XX 44 XX XX XX XX XX XX XX XX XX XX XX
> 50: UU XX UU XX XX XX XX XX XX XX XX XX XX XX XX XX
> 60: XX XX XX XX 64 XX XX XX XX 69 XX XX XX XX XX XX
> 70: XX XX XX XX XX XX XX XX
> 
> The output is involved - which address should I use?

If it was there, the LM96000 chip would appear at address 0x2c, 0x2d or
0x2e. There's nothing at any of these addresses in your case, so the
chip doesn't appear to be connected to this bus. No amount of effort
will make the lm85 driver work in this case.

In fact the Intel documentation is pretty clear on the fact that the
LM96000 chip is connected to the PC87427 Super-I/O chip and not the
ICH6R south bridge. So you will need a completely different set of
drivers to make it work. Support for this configuration is not yet in
Linux mainstream but additional patches exist and we had some reports of
success already. See the following archived threads:

http://lists.lm-sensors.org/pipermail/lm-sensors/2005-June/012825.html
http://lists.lm-sensors.org/pipermail/lm-sensors/2005-November/014401.html

And this site:

http://bmcsensors-26.sourceforge.net/

Beware that it'll involve switching to a more recent kernel, patching
it and recompiling it from source.

-- 
Jean Delvare

