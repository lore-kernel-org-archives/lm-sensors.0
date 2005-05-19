From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:16 +0000
Subject: ticket 1775
Message-Id: <20040921075148.M31686@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <E1C9PtS-000754-00@mendel.bio.caltech.edu>
In-Reply-To: <E1C9PtS-000754-00@mendel.bio.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > So please first try the following line:
> >
> > options w83781d force_w83782d=0,0x28 force_subclients=0,0x28,0x48,0x49
> >   force_w83627hf=0,0x2c force_subclients=0,0x2c,0x4a,0x4b init=0
> >
> >
> > (basically, 0x2d becomes 0x28) and try again.
> 
> Put that in /etc/modprobe.conf and only this in /etc/sysconfig/lm_sensors
> 
> MODULE_0=i2c-amd756
> MODULE_1=w83781d
> 
> That did eliminate the warning on start up and the values are correct.

The more I think of it, the more I suspect that the
"force_subclients=0,0x28,0x48,0x49" part is ignored. Most probably, it just
happens that the W83782D subclient addresses were already correct and didn't
need forcing.

> Um, well, the alarm seems to come and go here:
> 
> VCore 1:   +1.73 V  (min =  +1.66 V, max =  +1.94 V)
> sometimes it reads ALARM too, sometimes not. The Voltage
> shown doesn't change though.

No idea. You could try to periodically dump the chip contents (using i2cdump 0
0x28 or i2cdump 0 0x2c) and see if the alarms shows there too (bit 1 of
register 0x41). If it does, this is a hardware issue. If it doesn't, it might
be a software bug. You may try turning PCI Passive Release and/or PCI Delayed
Transaction off in your BIOS configuration and see it it helps.

> These two sets of values still look wrong values to me, the
> first is awfully high (not sure where VRM1 is, but it shouldn't
> be higher than the CPU temps) and the DDR voltage looks
> low.  The air coming out of the back of the case is warm
> but not uncomfortably hot, feels like about 42-44 C.
> 
> VRM1 Temp:   +62?C  (high =   -67?C, hyst =  -101?C)   sensor = 3904
> transistor
> DDR V:     +1.23 V  (min =  +1.65 V, max =  +2.05 V)

VRM1 is obviously the voltage regulator module for CPU1. I wouldn't be
surprised that it gets hot, although I admit that 62 degrees C is too much.

DDR is supposedly 2.5V as far as I know, so the reading probably needs a
compute line (@*2, @/2). Strange that the alarm doesn't show while the value
is obviously out of range. You should change the limits as well, to 2.4 and
2.6V for example.

> These are minor problems though, since all I really need to
> keep an eye on are the CPU fan speeds and CPU temps.

Glad we could get it to work again. I'd suggest that you provide feedback to
Tyan once you get things OK on your system. That way we can hope that other
users will benefit from your experience.

-- 
Jean Delvare
http://khali.linux-fr.org/
