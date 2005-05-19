From: j.dittmer@portrix.net (Jan Dittmer)
Date: Thu, 19 May 2005 06:23:51 +0000
Subject: add eeprom i2c driver
Message-Id: <3E80AF19.3010708@portrix.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E806AC6.30503@portrix.net> <20030325172024.GC15823@kroah.com>
In-Reply-To: <20030325172024.GC15823@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com

Greg KH wrote:
> On Tue, Mar 25, 2003 at 03:42:14PM +0100, Jan Dittmer wrote:
> 
>>This adds support for reading eeproms.
>>Tested against latest bk changes with i2c-isa.
> 
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
> 

Looks good, I'll try to come up with a converted version of via686a 
later. Should tidy up a lot.

Jan

