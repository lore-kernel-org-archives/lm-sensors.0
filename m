From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:37 +0000
Subject: [BK PATCH] i2c driver fixes for 2.6.2-rc2
Message-Id: <1075455411.401a25b3ebeff@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040127233242.GA28891@kroah.com> <20040129004402.GC5830@werewolf.able.es> <1075365845.4018c7d5353d7@imp.gcu.info> <20040129222135.GC5768@werewolf.able.es> <20040129225659.GA11872@werewolf.able.es> <20040130033853.GG992@earth.solarsys.private>
In-Reply-To: <20040130033853.GG992@earth.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com

Quoting "Mark M. Hoffman" <mhoffman@lightlink.com>:

> * J.A. Magallon <jamagallon@able.es> [2004-01-29 23:56:59 +0100]:
>
> > Oops, not so good:
> >           
> > > -12V:     -12.18 V  (min = -12.57 V, max = -11.35 V)    ALARM
> > > -5V:       -4.96 V  (min =  -5.25 V, max =  -4.74 V)    ALARM
> > 
> > Why ALARM ?
> 
> The alarm indicator is "sticky".  Even though the present
> readings are within limits, the alarm says that the voltage
> moved outside its limit since the last time you ran sensors.
> 
> Trying running sensors 5 times, at 2 second intervals.  If
> the voltage always stays within the limits but the alarm
> is not cleared, then maybe there is a problem with the
> driver.  If that's the case, please follow up on the sensors
> mailing list.

What Mark says is perfectly true as a generic remark, but this isn't the
problem here. The problem is that the limits of negative voltages are
swapped. Internally, the low limit is the one nearer from 0, i.e. the
lesser in absolute value. Your output shows the contrary.

This is a bug in the driver, or libsensors, or both. We have to take a
look at this really soon. This is on my to-do list for some times
already, just gimme some more time.

A temporary way to workaround the problem is to swap the limits in
/etc/sensors.conf, but this will cause problems if you are using 2.4
and 2.6 kernels on the same system, because the bug shows only in 2.6.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
