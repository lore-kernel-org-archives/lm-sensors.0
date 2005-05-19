From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:00 +0000
Subject: sensors works, but no RAW
Message-Id: <20040606223921.5b68e29b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0405241630260.8743@benthos.lqjr.qc.ca>
In-Reply-To: <Pine.LNX.4.58.0405241630260.8743@benthos.lqjr.qc.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Hi, I have a little problem with sensors, and was wondering what I
> did wrong.
> 
> I've juste updated my kernel from 2.4.25 to 2.6.6
> 
> I compiled all of the I2C chips/alhgorithms/buses as Modules, and
> compiled lm-sensors 2.8.6 and followed your 2.6 kernel guide on the
> website.
> 
> Once that was done, I tried loading the modules and trying out
> sensors. It worked.
> (...)
> But my tellerstats scripts wern't very happy.
> seems they couldn't find the raw files.
> Well... neither can I !
> their is no /proc/sys/dev/sensors where the used to be located.
> Has it been removed in the 2.6 kernel? Did I forget to include
> something?

You did not forget anything, it was removed, or more precisely it was
replaced. The kernel/user-space interface is now under sysfs. Take a
look at /sys/bus/i2c/devices, everything is there.

So your scripts definitely need to be updated to support the new
interface.

> I tried runnig sensors-detect see if maybe some things had changed.
> sensors-detect came up with the smsc47m1 driver instead of the 
> as99127f like it used to in 2.4.

This surprises me. These are completely different chips, it isn't
possible to misdetect one as the other.

The SMSC chip is a Super-I/O chip which has fans monitoring and control
capabilities. These capabilities may or may not be used on your
motherboard. The driver hasn't been ported to Linux 2.6 yet (although
Gabriele Gorla is working on it).

If sensors-detect doesn't detect your Asus chip, this needs fixing. I'd
need a dump of the chip (using i2cdump) for this.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
