From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:51 +0000
Subject: add eeprom i2c driver
Message-Id: <3E80E36C.1DCB0BE@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030325172024.GC15823@kroah.com>
In-Reply-To: <20030325172024.GC15823@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean described the history of the driver well.

I would call it more of a "demonstration" driver than something
that is exceptionally useful.
(the CVS continues that tradition, I added I2C Block read capability to the
driver, more as a demonstration and block read test than anything else).

It's also useful to us as a diagnostic tool with users -
(if eeprom works then the i2c bus works. if eeprom is the only
thing found on the i2c bus then the sensors must be on the ISA bus).

As such, I'm not really sentimental about the existing interface in /proc
or what it could be in sysfs, or whether it goes into the kernel at all. 
If the debate makes it more trouble than
it's worth to get into the kernel, it can stay out of the kernel
as far as I'm concerned.

For Greg, it's probably best to start with lm75, not eeprom, to review
the changes W.R.T. sysfs.

I also note for Deepak's benefit that 512 byte I2C eeproms
will appear as two separate 256 byte eeproms at consecutive I2C addresses
using the existing driver. There's no way for any driver to distinguish
these two cases, it would have to be a user-supplied parameter
if you wished to consolidate the two halves of the eeprom under one sysfs or proc directory.

We of course may be interested in including Deepak's driver in our package as well
if it makes sense.

mds



Jean Delvare wrote:
> 
> > I would like to suggest completely re-writing the user interface to
> > the EEPROM device.  As an applications programmer, I should not have
> > to open a separate sysfs file for each 16 bytes in the EEPROM. I
> > should be able to open a single file and perform read/write/llseek
> > operations on the file descriptor. I don't think that the actual data
> > of the EEPROM device is something that belongs in sysfs, just as the
> > data on a hard drive or from a serial port is not read through their
> > sysfs counterparts. Furthermore, I think that checksum data is not
> > something that should be in the kernel, but in the application that is
> > using it.  An application can open() /dev/eepromX (/dev/nvramX maybe?)
> > and read the data and ensure that the checksum is OK.  Not all
> > applications will have the same checksum mechanism, location, etc.
> 
> The things were this way simply because the EEPROM driver started its
> life as a component of the LM Sensors project. Actually, an EEPROM isn't
> a sensor, and it was handled by LM Sensors simply because EEPROMs are
> found on the I2C bus.
> 
> If we decide to change the interface for this driver, it means
> (methinks) that it will have to leave the LM Sensors project completely,
> since it won't be handled by sensors-detect nor libsensors/sensors. I
> don't pretend it cause any sort of problem, I just want to make sure you
> are aware of it.
> 
> Actually, it may be preferable to move the EEPROM driver away. If I
> remember correctly, the LM Sensors team doesn't especially like this
> driver ;) And I don't think anyone would look for an EEPROM driver
> there.
> 
> We have a pair of scripts that dump some EEPROM information, written in
> Perl. I can rewrite them if there's a new interface to the data, and
> eventually they'll leave the LM Sensors project if there's no reason to
> keep them there.
> 
> Mark, Phil, feel free to speak your mind if I'm wrong!
> 
> --
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/
