From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 05 Jul 2013 07:34:37 +0000
Subject: Re: [lm-sensors] sensors quit working
Message-Id: <20130705093437.62cb65bf@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <201307042128.r64LSOcp022588@mail01.lsn.net>
In-Reply-To: <201307042128.r64LSOcp022588@mail01.lsn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Leslie,

On Thu, 4 Jul 2013 16:28:23 -0500, Leslie Rhorer wrote:
> I had sensors working pretty well, but then I upgraded my distro and it quit
> working completely.  I tried running sensors-detect, and it reports I need
> to load it87, k10temp, and fam15_power in order to run sensors.  I can load
> k10temp, but sensors does not find any monitor points when I do.
> 
> Attempting to load it87 give an error: FATAL: "Error inserting it87
> (/lib/modules/2.6.32-5-amd64/kernel/drivers/hwmon/it87.ko): No such device"
> 
> The module fam15_power.o does not exist.

It is named fam15h_power. But this driver is only available since
kernel 3.0.

> I vaguely recall having some
> issues with fam15_power when I installed this motherboard several months
> ago, but I also recall it did not seem to do very much that I needed.
> 
> There are backup versions of it87.ko and k10temp.ko in the
> /lib/modules/2.6.32-5-amd64/kernel/drivers/hwmon directory.
> 
> How should I proceed?

Send us the summary output of sensors-detect as a starter, because at
this point we have no idea what hardware you have.

Kernel 2.6.32 isn't exactly new so it is no surprise that it wouldn't
support relatively recent hardware out of the box. I can only guess
that you previously had to build standalone flavors of the monitoring
drivers. This would explain the backup versions of these drivers. If
you reinstalled your system, you may have to build these standalone
drivers again. I have a k10temp driver here:

http://khali.linux-fr.org/devel/lm-sensors/drivers/k10temp/

and an it87 driver there:

http://khali.linux-fr.org/devel/lm-sensors/drivers/it87/

I can't remember how up-to-date they are exactly, let me know if have
problem building them or find bugs in them. Instructions are at:

http://khali.linux-fr.org/devel/lm-sensors/drivers/INSTALL

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
