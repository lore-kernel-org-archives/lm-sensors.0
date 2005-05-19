From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:25 +0000
Subject: lm_sensors SiS730
Message-Id: <20011113141311.I5776@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200111132117.NAA12073@jerry-garcia.accessgroupinc.com>
In-Reply-To: <200111132117.NAA12073@jerry-garcia.accessgroupinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Bob, I've got one of these mobo's.  Nice all-in-one solution, and
it's quite reasonably priced!  Anyways, I'm using the IT87 driver.
Here's what my lsmod looks like:

[phil@drtheopolis phil]$ lsmod
Module                  Size  Used by
it87                    7056   0
eeprom                  3120   0 (unused)
ddcmon                  3120   0 (unused)
i2c-isa                 1168   0 (unused)
matorb                  2656   0 (unused)
i2c-proc                6304   0 [it87 eeprom ddcmon matorb]
i2c-core               12944   0 [it87 eeprom ddcmon i2c-isa matorb i2c-proc]

Not everything is being used (eeprom, ddcmon, matorb).  The IT87 is
accessed via the ISA bus.  The I2C/SMBus isn't accessable yet.  There
is a driver written (i2c-sis5595) but it doesn't like this hardware
for some reason.  Possibly because of the Bios used.  Technical
information and help for the SiS chips are hard to come by, too.

PS- my temp values aren't right, but I'm using an older sensors.conf. 


Phil

On Tue, Nov 13, 2001 at 01:17:29PM -0800, Bob Ramstad wrote:
> Howdy.  I wanted to write and first thank you for the i2c and
> lm_sensors work.  It's cool that such a package exists for linux.
> 
> I have an ASUS A7S-VM m/b with SiS730 chipset and i2c + lm_sensors
> 2.6.1 packages which I've compiled and installed.
> 
> Is there anything I could do to help with testing out a solution for
> this chipset?  Has anyone proposed an "alpha" solution that I could
> try?
> 
> The website makes a cryptic reference to it87, if you can give me
> explicit directions on how to set things up to try that out, I'd be
> happy to give it a shot and report back.
> 
> Thanks in advance, and of course, if this chipset is just too far
> below the radar to be worth the time to fiddle with, I understand.
> 
> -- Bob

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
