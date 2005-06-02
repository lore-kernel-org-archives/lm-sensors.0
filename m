From: johnpol@2ka.mipt.ru (Evgeniy Polyakov)
Date: Thu, 02 Jun 2005 22:02:29 +0000
Subject: [lm-sensors] [PATCH 2.6.12-rc5-mm2] w1 search cleanup
Message-Id: <20050603000313.360fd6a6@zanzibar.2ka.mipt.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <F06EB2894F3F0D45AD9BEA7246DE9C9076C1EA@WCSEXCMBS1.ad.wabtec.com>
In-Reply-To: <F06EB2894F3F0D45AD9BEA7246DE9C9076C1EA@WCSEXCMBS1.ad.wabtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 2 Jun 2005 13:09:52 -0400
<BGardner@Wabtec.com> wrote:

Hello, Ben.

I very like your changes, although I did not tested it yet, will
do it later this week.
But I have some comments about.

> While writing a driver for the DS2482 (an i2c to w1 bridge), 
> I made a few enhancements to the w1 subsystem.
> 
> 1.
> I added a new I/O function: triplet
> A triplet reads two bits and writes a direction bit.  The DS2482
> implements this in hardware.
> I modified w1_search() to use w1_triplet() at its core.
> 
> 2.
> I cleaned up the I/O functions to separate emulated vs native w1
> support.
> A w1 bus master must be able to do one of:
>   a. Set and sample the line via write_bit() and read_bit()
>   b. Support reset_bus() and touch_bit()
> Function set (a) is only needed for emulated devices (ie, a parallel
> port).
> I hid w1_read_bit() and w1_write_bit() behind w1_touch_bit(), and
> changed functions to call touch_bit() instead or read/write_bit().

This changes are quite good.

> 3. 
> Searching is fairly slow - it requires about 200 w1 bit cycles per
> device, multiplied by the number of devices on the bus.
> I modified the w1_process() to NOT periodically search the bus.
> A sysfs entry was added to request a search. (w1_master_search).
> To request a search, echo anything into w1_master_search and it'll run
> another search.

This one is very usefull, but we do want a mode, when w1 core
repeatedly scans for devices - concider ibuttons which can only
"exists" and be found for a couple of seconds, and it is 
not always possible and sensible to have some userspace writing to the sysfs
file.
I would like to have 2 search modes - writing "1" to sysfs turns default
always-scan mode into write-on-request mode, and writing "2" turns it back.
Or something similar...

> 4.
> I added a default family so that a slave device will get reported even
> if there isn't a driver for that family.
> 
> Signed-off-by: Ben Gardner <bgardner@wabtec.com>

Besides some whitespace and some brackets places [ugh, Greg will kill me 
for such patches] and my above comment I do not have objections,
but I would like to test your changes first and see them presented
in a splitted series of patches. I see almost 10 major changes
in your patch :)

Thank you.

	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt
