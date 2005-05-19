From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:12 +0000
Subject: [PATCH] Driver Core patches for 2.6.9-rc1
Message-Id: <20040827084639.M35363@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <10934733881970@kroah.com> <1093485846.3054.65.camel@gaston> <20040826041019.GA8445@kroah.com>  <20040826112343.M51031@linux-fr.org> <1093563199.2170.168.camel@gaston>
In-Reply-To: <1093563199.2170.168.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Greg KH <greg@kroah.com>, sensors@Stimpy.netroedge.com, Linux Kernel list <linux-kernel@vger.kernel.org>

> > The i2c-keywest driver doesn't define any class for any of its I2C busses.
> > All hardware monitoring chips [1] do check the class, so they wont
> > possibly probe any chip on the i2c-keywest busses. It happens that on the
> > iBook2, the second I2C bus hosts an Analog Devices ADM1030 monitoring
> > chip, for which a driver has been developped recently. Without adding the
> > correct class bit (I2C_CLASS_HWMON) to the second bus of i2c-keywest,
> > iBook2 users can't get the adm1031 driver to handle their ADM1030 chip.
> 
> That bus also contains other stuffs, I'd prefer the in-kernel 
> specific driver for this model to be used rather than some generic stuff.

Does such a driver exist already? How does it differ from i2c/chips/adm1031.c?

> > Benjamin, you seem to guard the i2c-keywest driver very closely. Is there
> > anything special about this driver? My patch was rather simple and
> > non-intrusive, and probably not worth reverting within the hour. Much ado
> > about nothing, if you want my opinion, with all due respect.
> 
> It was wrong to check on the bus number like that. i2c-keywest is 
> used on a variety of models to driver totally different i2c busses,
> and at this point, we can't arbitrarily say "bus 1 is HW monitoring".
> It totally depends on the machine model.

It's not quite what the patch did. It's more like "bus 1 *may* host hardware
monitoring chips". It doesn't prevent non-hardware monitoring chips from
working. It simply allows hardware-monitoring chip drivers to probe that bus
when loaded.

I admit it does this for all systems using i2c-keywest, while only the iBook2
is known to actually have a hardware monitoring chip on that bus. However, I
would guess that future iBooks are likely to have it as well. And probing the
bus when no hardware monitoring chip is present shouldn't harm.

The fact that bus probing is needed is a known weakness of the I2C/SMBus
protocol. This isn't i2c-keywest-specific, and works rather well (now).
Refined detection methods and the new class bitfield are doing well.

> Besides, I don't like generic drivers playing with those thermal control
> stuffs, I prefer drivers that have been tuned for those specific machine
> models.

Again, please tell me what your specific driver will do that ours don't (or
the other way around). I don't much enjoy the idea of having two different
drivers for the same chip.

> > Could you please explain why my patch doesn't make sense? Similar changes
> > were made to several i2c bus drivers already [2] [3], and it never caused
> > any problem.
> 
> As I wrote earlier. Just testing the bus number and arbitrarily deciding
> bus 1 is HWMON makes no sense.

If this is the problem, and if you have a way to set the class to
I2C_CLASS_HWMON if and only if the system is an iBook2, that's fine with me
(although I don't think it is necessary to be that restrictive).

Thanks,

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
