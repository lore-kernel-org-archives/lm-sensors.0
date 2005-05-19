From: kyosti.malkki@welho.com (=?ISO-8859-1?Q?Ky=F6sti_M=E4lkki?=)
Date: Thu, 19 May 2005 06:24:27 +0000
Subject: lm_sensors2/prog/dump i2cbusses.c
Message-Id: <Pine.LNX.4.53.0311300130410.4386@cosmos.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <3FC6898D.DF9ECF07@paradyne.com>
In-Reply-To: <3FC6898D.DF9ECF07@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 27 Nov 2003, Mark Studebaker wrote:

> The 2.6 i2c-dev bus numbers don't necessarily match i2c-adapter bus
> numbers.
> If you rmmod and re-insmod a bus driver, the driver seems to get its old
> i2c-dev bus number back. But the i2c-adapter number increments.
> Don't know why. It would be much better if they matched.

In i2c-dev adapter gets the first empty minor device.

In i2c-core, previously, adap->nr (bus number) was an index in the array
of adapters so it also took the first empty slot.

In 2.6 the array of adapters in i2c-core has been changed to a list and
bus number is now just ever incrementing as you have noticed. The number
was pretty dynamic anyway, as it depended of the order adapters were
loaded.

IMO, one should point to i2c bus by its parent device. That is, pick the
i2c bus behind pci device ABAD:BEEF, the one in parallel port etc, sysfs
should have this information.

-- 
  Ky?sti M?lkki  <kyosti.malkki@welho.com>  +358 50 462 8786
