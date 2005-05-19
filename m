From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:27 +0000
Subject: lm_sensors2/prog/dump i2cbusses.c
Message-Id: <3FC95486.251A4314@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3FC6898D.DF9ECF07@paradyne.com>
In-Reply-To: <3FC6898D.DF9ECF07@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks for the explanation. more below.

Ky?sti M?lkki wrote:
> 
> On Thu, 27 Nov 2003, Mark Studebaker wrote:
> 
> > The 2.6 i2c-dev bus numbers don't necessarily match i2c-adapter bus
> > numbers.
> > If you rmmod and re-insmod a bus driver, the driver seems to get its old
> > i2c-dev bus number back. But the i2c-adapter number increments.
> > Don't know why. It would be much better if they matched.
> 
> In i2c-dev adapter gets the first empty minor device.
> 
> In i2c-core, previously, adap->nr (bus number) was an index in the array
> of adapters so it also took the first empty slot.
> 
> In 2.6 the array of adapters in i2c-core has been changed to a list and
> bus number is now just ever incrementing as you have noticed. The number
> was pretty dynamic anyway, as it depended of the order adapters were
> loaded.
> 
> IMO, one should point to i2c bus by its parent device. That is, pick the
> i2c bus behind pci device ABAD:BEEF, the one in parallel port etc, sysfs
> should have this information.
> 



My main goal in bus numbering was
to list (and number) the installed i2c busses available for probing via
i2c-dev.
That's what i2cdetect, i2cdump, and i2cset now do with no arguments,
both for 2.4 and 2.6.


The secondary goal, which is difficult (and impossible if i2c-dev is not
installed)
is to number the busses the same in the 'sensors' output, so that we can
continue to say (as we have for years) after receiving a 'sensors'
output
listing

w83781d-i2c-1-2d
Adapter: SMBus ALI15X3 adapter at e800
Algorithm: SMBus algorithm
VCore 1:   +2.22 V  (min =  +2.53 V, max =  +3.09 V)       ALARM  
VCore 2:   +2.22 V  (min =  +2.53 V, max =  +3.09 V)       ALARM  
+3.3V:     +3.54 V  (min =  +2.98 V, max =  +3.63 V) 
...

"hey, user, do an 'i2cdump 1 0x2d' and send us the results".

This won't work now because the 'sensors' output currently 
uses sysfs numbers, not i2c-dev numbers.

So I wanted people to know that.

mds
