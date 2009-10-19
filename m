From: Adam Nielsen <a.nielsen@shikadi.net>
Date: Mon, 19 Oct 2009 23:59:44 +0000
Subject: Re: [lm-sensors] Gigabyte GA-P35-DS3P - VID Zero value
Message-Id: <4ADCFD70.6070106@shikadi.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20091019164516.701032uxlen5ai2k@mail.simonandkate.net>
In-Reply-To: <20091019164516.701032uxlen5ai2k@mail.simonandkate.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Setting /sys/class/hwmon/hwmon0/device/vrm to 100 instead of 110 "fixes"
> this issue. Or I should say, it means I get a value - 1.088 V - at VID.
> Whether it is right or not... ?

I suspect it is wrong - I was looking at this issue this morning and the
Core2 CPUs are correctly listed in the hwmon-vid driver and I too get a
vrm value of 110 which is correct for my CPU.  Setting a different vrm
value causes a different formula to be used when calculating the voltage.

I was wondering whether the VID lines aren't actually connected to the
it87 chip, but it looks like they are, just not all of them.

It looks like (if that's correct) the only option is to hack hwmon-vid
to use less VID pins or something to get the correct value out.

Cheers,
Adam.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
