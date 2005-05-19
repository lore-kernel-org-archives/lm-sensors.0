From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:25 +0000
Subject: lm_sensors SiS730
Message-Id: <3BF5ABB9.5377B649@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200111132117.NAA12073@jerry-garcia.accessgroupinc.com>
In-Reply-To: <200111132117.NAA12073@jerry-garcia.accessgroupinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Phil,
to correct what you said about i2c support for the 730,
the problem is not the BIOS.

The i2c-sis5595 driver supports the 5595 chip only.
There are a large number of SiS chips that have come out since
then that have a 5595 PCI ID device inside them but they are
not 5595's and the driver won't work.
Since release 2.6.1, the sis5595 and i2c-5595 drivers have
had a 'blacklist' that recognizes these unsupported chips so
that the driver won't load.

A new driver will have to be written for the 730 and similar chips.
For further info see our 'new drivers' page.

mds


phil@netroedge.com wrote:
> 
> Hi Bob, I've got one of these mobo's.  Nice all-in-one solution, and
> it's quite reasonably priced!  Anyways, I'm using the IT87 driver.
> Here's what my lsmod looks like:
> 
> [phil@drtheopolis phil]$ lsmod
> Module                  Size  Used by
> it87                    7056   0
> eeprom                  3120   0 (unused)
> ddcmon                  3120   0 (unused)
> i2c-isa                 1168   0 (unused)
> matorb                  2656   0 (unused)
> i2c-proc                6304   0 [it87 eeprom ddcmon matorb]
> i2c-core               12944   0 [it87 eeprom ddcmon i2c-isa matorb i2c-proc]
> 
> Not everything is being used (eeprom, ddcmon, matorb).  The IT87 is
> accessed via the ISA bus.  The I2C/SMBus isn't accessable yet.  There
> is a driver written (i2c-sis5595) but it doesn't like this hardware
> for some reason.  Possibly because of the Bios used.  Technical
> information and help for the SiS chips are hard to come by, too.
