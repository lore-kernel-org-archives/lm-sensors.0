From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: [PATCH 2.6] restore correct vaio handling in eeprom driver
Message-Id: <20040114194239.GM6107@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040111205346.6182c330.khali@linux-fr.org>
In-Reply-To: <20040111205346.6182c330.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Jan 11, 2004 at 08:53:46PM +0100, Jean Delvare wrote:
> Here is a patch to the eeprom driver in 2.6.1 that changes the way Vaio
> eeproms are handled. In 2.6.1, the eeprom is readable only by root,
> which isn't consistent with the 2.4 driver which simple hides (i.e.
> fills it with zeroes) the first row (16 bytes) of the eeprom to regular
> users.
> 
> The patch restores a similar behaviour in the 2.6 driver. Greg, feel
> free to apply it if you like it.

Hm, why not just prevent the user from reading those bytes at all?
Something like what the pci core does for the pci config files (see
drivers/pci/pci-sysfs.c::pci_read_config().

I'd take that kind of a patch :)

> I'd also have a remark. In the 2.4 driver I had divided the driver into
> arbitrary slices (32 bytes each) in order to improve sensors'
> responsiveness. As the driver was ported to 2.6, it was dicussed wether
> such an optimization would be possible, since the whole eeprom is now
> exported as a single file. Our conclusion back to that time was that the
> optimization wasn't possible anymore. But now that I saw the actual
> code, it seems clear to me that it is. The eeprom_read fuction can
> return any part of the file that is requested, not necessarily the whole
> file. So the same mechanism used in the 2.4 driver could be added to the
> 2.6 driver. Two questions then:
> 
> 1* Would the current 2.6 tweaks in libsensors let sensors take any
> benefit of it?
> 
> 2* Such a trick makes the driver a little bigger (more internal vars,
> more code), and slightly slower in the case you really want to read the
> whole file. The step was taken for 2.4, will we do the same for 2.6?

Is it really worth it?  This isn't a speed issue at all, right?  Code
simplicity should win out in such a case.

thanks,

greg k-h
