From: dsaxena@mvista.com (Deepak Saxena)
Date: Thu, 19 May 2005 06:23:51 +0000
Subject: add eeprom i2c driver
Message-Id: <20030325212753.GA21498@xanadu.az.mvista.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030325172024.GC15823@kroah.com>
In-Reply-To: <20030325172024.GC15823@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mar 25 2003, at 09:20, Greg KH was caught saying:
> On Tue, Mar 25, 2003 at 03:42:14PM +0100, Jan Dittmer wrote:
> > This adds support for reading eeproms.
> > Tested against latest bk changes with i2c-isa.
> 
> I'd like to hold off in submitting the i2c chip drivers just yet, due to
> the changes for sysfs that are going to be needed for these drivers.
> 
> As an example of the changes necessary, here's a patch against the i2c
> cvs version of the eeprom.c driver that converts it over to use sysfs,
> instead of the /proc and sysctl interface.  It's still a bit rough, but
> you should get the idea of where I'm wanting to go with this.  As you
> can see, it takes about 100 lines of code off of this driver, which is
> nice.
> 
> I'm copying the sensors list too, as they wanted to see how this was
> going to be done.
> 
> Comments?

I would like to suggest completely re-writing the user interface to the 
EEPROM device.  As an applications programmer, I should not have to 
open a separate sysfs file for each 16 bytes in the EEPROM. I should be 
able to open a single file and perform read/write/llseek operations 
on the file descriptor. I don't think that the actual data of the EEPROM 
device is something that belongs in sysfs, just as the data on a hard drive
or from a serial port is not read through their sysfs counterparts.
Furthermore, I think that checksum data is not something that should be 
in the kernel, but in the application that is using it.  An application can 
open() /dev/eepromX (/dev/nvramX maybe?) and read the data and ensure that
the checksum is OK.  Not all applications will have the same checksum
mechanism, location, etc.  

From my experience in seeing I2C eeproms on embedded systems, most 
people end up writing a custom little driver that does just what I 
said above: read/write/llseek. The eeprom driver should export the data
for each eeprom through /dev/eeprom interfaces This also allows for someone
to add a driver for larger EEPROMs (I have 512byte eeproms on some embedded 
boards) w/o having to add even more entries to sysfs for the remaining data.

~Deepak

-- 
Deepak Saxena
MontaVista Software - Powering the Embedded Revolution - www.mvista.com
