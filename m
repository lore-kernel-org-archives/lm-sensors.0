From: Adam Nielsen <a.nielsen@shikadi.net>
Date: Tue, 20 Oct 2009 11:03:50 +0000
Subject: Re: [lm-sensors] Gigabyte GA-P35-DS3P - VID Zero value
Message-Id: <4ADD9916.3080301@shikadi.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20091019164516.701032uxlen5ai2k@mail.simonandkate.net>
In-Reply-To: <20091019164516.701032uxlen5ai2k@mail.simonandkate.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Thanks for clarifying that. Still new at all this stuff really... :)

That makes two of us ;-)

> Well, based on the git version of hwmon-vid.c the fact that
> /sys/class/hwmon/hwmon0/device/vrm is originally 110 on my system would
> seem to indicate then that the hwmon-vid driver is correctly setting the
> VRM version based on my Conroe CPU to 110. Is there any way to
> interrogate the hwmon-vid driver to see whether it is working at a lower
> level before the it87 driver reads it in?

All the hwmon-vid driver seems to do is ask the driver for the raw vid value
and run it through a formula.  It doesn't actually have anything to do with
hardware at all (other than detecting the CPU brand and model.)

> Perhaps the elrepo.org kmod-it87 driver that I am using needs to be
> updated with more recent code to support the different VID configuration
> of the 8718 and 8720 chips...

Quite possibly, but if you download the latest Linux kernel, compile and boot
that, and try again you'll know for sure whether code exists to handle it or
not.  Given the number of quirks motherboard sensors seem to have, I suspect
this issue is just another quirk that needs to be added to the it87 driver.

The next step is to probably get some raw vid values off the it87 chip to see
what they look like - if those are all zero then we know the lines aren't
connected, but if there are some values there it should in theory be possible
to map them to vid voltages.  I guess this is where that isadump output you
posted comes in...

It's a shame there's no "passthrough" vrm version that disables the formula
and shows the raw vid value, as that would probably be quite helpful.  Maybe
it's worth adding a patch to do just that?

Cheers,
Adam.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
